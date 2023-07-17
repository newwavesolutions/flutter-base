import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/enums/profile_menu.dart';
import 'package:flutter_base/ui/pages/profile/profile_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AppCubit appCubit;
  final ProfileNavigator navigator;

  ProfileCubit({
    required this.appCubit,
    required this.navigator,
  }) : super(const ProfileState());

  Future<void> getUser() async {
    emit(
      state.copyWith(userStatus: LoadStatus.loading),
    );
    try {
      if (appCubit.state.user != null) {
        emit(state.copyWith(
          user: appCubit.state.user,
          userStatus: LoadStatus.success,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(userStatus: LoadStatus.failure),
      );
    }
  }

  Future<void> signOut() async {
    emit(
      state.copyWith(signOutStatus: LoadStatus.loading),
    );
    try {
      await appCubit.signOut();
    } catch (e) {
      emit(
        state.copyWith(signOutStatus: LoadStatus.failure),
      );
    }
  }

  void handleMenuTapped({
    required ProfileMenu option,
  }) {
    // TODO: Thêm handle cho các options còn lại
    if (option == ProfileMenu.logout) {
      signOut();
    } else if (option == ProfileMenu.openPolicy) {
      launchUrl(Uri(
        scheme: 'https',
        host: 'wiki.newwave.vn',
        path: '/home',
      ));
    } else if (option == ProfileMenu.setting) {
      navigator.openSetting();
    }
  }

  Future<void> openUpdateProfilePage() async {
    bool result = await navigator.openUpdateProfile();
    if (result) {
      getUser();
    } else {
      return;
    }
  }

  void openUpdateAvatarPage() {
    navigator.openUpdateAvatar();
  }
}
