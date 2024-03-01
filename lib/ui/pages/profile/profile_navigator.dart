import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_base/utils/permission_utils.dart';

class ProfileNavigator extends AppNavigator {
  ProfileNavigator({required super.context});

  Future<bool> openUpdateProfile() async {
    var result = await pushNamed(AppRouter.updateProfile);
    return result as bool;
  }

  void openUpdateAvatar() {
    pushNamed(AppRouter.updateAvatar);
  }

  void openDeleteAccount() {
    pushNamed(AppRouter.deleteAccount);
  }

  Future<void> requestStoragePermission() async {
    final bo = await PermissionUtils.requestPhotosPermission(context);
    logger.t(bo);
  }

  Future<void> requestCameraPermission() async {
    final bo = await PermissionUtils.requestCameraPermission(context);
    logger.t(bo);
  }
}
