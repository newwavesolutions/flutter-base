import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';

class NotificationListNavigator extends AppNavigator {
  NotificationListNavigator({required super.context});

  void openNotificationDetail() {
    pushNamed(AppRouter.notificationDetail);
  }
}
