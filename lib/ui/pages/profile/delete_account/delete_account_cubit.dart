import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'delete_account_navigator.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountNavigator navigator;

  DeleteAccountCubit({
    required this.navigator,
  }) : super(const DeleteAccountState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(deleteAccountStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(deleteAccountStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(deleteAccountStatus: LoadStatus.failure));
    }
  }
}
