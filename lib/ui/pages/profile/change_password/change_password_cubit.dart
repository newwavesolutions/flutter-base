import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'change_password_navigator.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordNavigator navigator;

  ChangePasswordCubit({
    required this.navigator,
  }) : super(const ChangePasswordState());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    //TODO
  }
}
