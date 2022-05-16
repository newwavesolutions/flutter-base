import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void signOut() async {
    // state.signOutStatus.value = LoadStatus.loading;
    // ///Call signOut API here
    // await Future.delayed(Duration(seconds: 2));
    // authService.signOut();
    // state.signOutStatus.value = LoadStatus.success;
    // Get.off(SignInPage());
  }
}
