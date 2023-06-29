import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/repositories/notification_respository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/notification/notification_detail/notification_detail_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/widgets/notification_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'notification_list_cubit.dart';

class NotificationListArguments {
  String param;

  NotificationListArguments({
    required this.param,
  });
}

class NotificationListPage extends StatelessWidget {
  final NotificationListArguments? arguments;

  const NotificationListPage({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final notificationRepo =
            RepositoryProvider.of<NotificationRepository>(context);
        return NotificationListCubit(
          notificationRepository: notificationRepo,
        );
      },
      child: const NotificationListChildPage(),
    );
  }
}

class NotificationListChildPage extends StatefulWidget {
  const NotificationListChildPage({Key? key}) : super(key: key);

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
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          InkWell(
            onTap: _markAllAsReadNotification,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Text(
                    "Mark all Read",
                    style: AppTextStyle.blackS16W800,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<NotificationListCubit, NotificationListState>(
      bloc: _cubit,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: _onRefreshData,
          child: ListView.separated(
            controller: _scrollController,
            itemCount: state.notifications?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 14,
              );
            },
            itemBuilder: (context, index) {
              return NotificationWidget(
                notification:
                    state.notifications?[index] ?? NotificationEntity(),
                onPressed: () {
                  _onPressNotification(
                    notificationEntity:
                        state.notifications?[index] ?? NotificationEntity(),
                  );
                },
                onLongPressed: () {
                  _markAsReadNotification(
                      id: state.notifications?[index].id ?? 0);
                },
              );
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
      _cubit.fetchNextNotifications();
    }
  }

  void _onPressNotification({
    required NotificationEntity notificationEntity,
  }) {
    Get.toNamed(
      RouteConfig.notificationDetail,
      arguments: NotificationDetailArguments(
        notification: notificationEntity,
      ),
    );
  }

  Future<void> _onRefreshData() async {
    _cubit.loadInitialData();
  }

  void _markAllAsReadNotification() {
    _cubit.markAllNotificationAsRead();
  }

  void _markAsReadNotification({required int id}) {
    _cubit.markNotificationAsRead(id: id);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
