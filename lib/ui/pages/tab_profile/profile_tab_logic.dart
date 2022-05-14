import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_tab_state.dart';

class ProfileTabCubit extends Cubit<ProfileTabState> {
  final state = ProfileTabState();

  ProfileTabCubit() : super(ProfileTabState());

  void signOut() async {
    // state.signOutStatus.value = LoadStatus.loading;
    // ///Call signOut API here
    // await Future.delayed(Duration(seconds: 2));
    // authService.signOut();
    // state.signOutStatus.value = LoadStatus.success;
    // Get.off(SignInPage());
  }
}
