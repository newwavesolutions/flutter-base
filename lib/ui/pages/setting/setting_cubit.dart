import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingState());
}
