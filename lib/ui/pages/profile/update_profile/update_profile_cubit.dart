import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/gender_type.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/profile/update_profile/update_profile_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileNavigator navigator;

  UpdateProfileCubit({
    required this.navigator,
  }) : super(const UpdateProfileState());

  Future<void> updateData({
    required String name,
    required DateTime birthday,
    required GenderType gender,
  }) async {
    //Todo
  }
}
