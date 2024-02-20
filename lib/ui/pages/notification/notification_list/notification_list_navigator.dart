import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:go_router/go_router.dart';

class NotificationListNavigator extends AppNavigator {
  NotificationListNavigator({required super.context});

  void openNotificationDetail() {
    GoRouter.of(context).pushNamed(AppRouter.notificationDetail);
  }
}
