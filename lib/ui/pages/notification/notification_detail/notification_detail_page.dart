import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/repositories/notification_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_detail_cubit.dart';

class NotificationDetailArguments {
  final NotificationEntity notification;

  NotificationDetailArguments({
    required this.notification,
  });
}

class NotificationDetailPage extends StatelessWidget {
  final NotificationDetailArguments arguments;

  const NotificationDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final notificationRepo =
            RepositoryProvider.of<NotificationRepository>(context);
        return NotificationDetailCubit(
            notificationRepository: notificationRepo);
      },
      child: NotificationDetailChildPage(
        notification: arguments.notification,
      ),
    );
  }
}

class NotificationDetailChildPage extends StatefulWidget {
  final NotificationEntity notification;

  const NotificationDetailChildPage({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  State<NotificationDetailChildPage> createState() =>
      _NotificationDetailChildPageState();
}

class _NotificationDetailChildPageState
    extends State<NotificationDetailChildPage> {
  late final NotificationDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.markNotificationAsRead(id: widget.notification.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Notification"),
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.notification.title ?? '',
            style: AppTextStyle.blackS16W800,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.notification.message ?? '',
            style: AppTextStyle.blackS16,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
