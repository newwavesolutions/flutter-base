import 'dart:math';

import 'package:flutter_base/ui/pages/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  final _names = ['thang1', 'thang2', 'thang3'];
  final _name2 = ['nguyen', 'nguyen 2', 'nguyemn 4'];

  final _random = Random();

  void change() {
    final name = _names[_random.nextInt(_names.length)];
    final name2 = _name2[_random.nextInt(_name2.length)];
    final age = (state.age ?? 1) + 1;
    emit(
      state.copyWith(
        firstName: name,
        lastName: name2,
        age: age,
      ),
    );
  }
}
