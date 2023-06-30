import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_navigator.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileNavigator navigator;

  ProfileCubit({
    required this.navigator,
  }) : super(const ProfileState());
}
