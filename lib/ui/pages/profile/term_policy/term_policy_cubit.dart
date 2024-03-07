import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'term_policy_navigator.dart';

part 'term_policy_state.dart';

class TermPolicyCubit extends Cubit<TermPolicyState> {
  final TermPolicyNavigator navigator;

  TermPolicyCubit({
    required this.navigator,
  }) : super(const TermPolicyState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(termPolicyStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(termPolicyStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(termPolicyStatus: LoadStatus.failure));
    }
  }
}
