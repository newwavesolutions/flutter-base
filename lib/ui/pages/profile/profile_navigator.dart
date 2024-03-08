import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';

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

  void openChangePassword() {
    pushNamed(AppRouter.changePassword);
  }

  void openTermPolicy() {
    pushNamed(AppRouter.termPolicy);
  }
}
