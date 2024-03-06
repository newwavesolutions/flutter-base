import 'package:flutter_base/ui/pages/profile/profile_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileNavigator navigator;

  ProfileCubit({
    required this.navigator,
  }) : super(const ProfileState());

  void setVersion(String version) {
    emit(state.copyWith(version: version));
  }
}
