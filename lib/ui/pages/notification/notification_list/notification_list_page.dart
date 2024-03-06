import 'package:flutter/material.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/notification_repository.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/widgets/notification_widget.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/list/list_empty_widget.dart';
import 'package:flutter_base/ui/widgets/list/list_error_widget.dart';
import 'package:flutter_base/ui/widgets/list/list_loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_list_cubit.dart';
import 'notification_list_navigator.dart';

class NotificationListArguments {
  String param;

  NotificationListArguments({
    required this.param,
  });
}

class NotificationListPage extends StatelessWidget {
  final NotificationListArguments? arguments;

  const NotificationListPage({
    super.key,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final notificationRepo =
            RepositoryProvider.of<NotificationRepository>(context);
        return NotificationListCubit(
          navigator: NotificationListNavigator(context: context),
          notificationRepository: notificationRepo,
        );
      },
      child: const NotificationListChildPage(),
    );
  }
}

class NotificationListChildPage extends StatefulWidget {
  const NotificationListChildPage({super.key});

  @override
  State<NotificationListChildPage> createState() =>
      _NotificationListChildPageState();
}

class _NotificationListChildPageState extends State<NotificationListChildPage> {
  late final NotificationListCubit _cubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _cubit = BlocProvider.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _cubit.fetchInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Notifications",
        showBackButton: false,
      ),
      body: SafeArea(
        child: BlocBuilder<NotificationListCubit, NotificationListState>(
          buildWhen: (prev, current) {
            return prev.loadDataStatus != current.loadDataStatus;
          },
          builder: (context, state) {
            if (state.loadDataStatus == LoadStatus.initial) {
              return Container();
            } else if (state.loadDataStatus == LoadStatus.loading) {
              return const ListLoadingWidget();
            } else if (state.loadDataStatus == LoadStatus.failure) {
              return ListErrorWidget(
                onRefresh: _onRefreshData,
              );
            } else {
              if (state.notifications.isEmpty) {
                return ListEmptyWidget(onRefresh: _onRefreshData);
              } else {
                return _buildNotificationList();
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return BlocBuilder<NotificationListCubit, NotificationListState>(
      bloc: _cubit,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: _onRefreshData,
          child: ListView.separated(
            controller: _scrollController,
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return NotificationWidget(
                notification: notification,
                onPressed: () {
                  _cubit.markNotificationAsRead(id: notification.id);
                  _cubit.navigator.openNotificationDetail();
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1);
            },
          ),
        );
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConfigs.scrollThreshold) {
      _cubit.fetchNextData();
    }
  }

  Future<void> _onRefreshData() async {
    _cubit.fetchInitialData();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
