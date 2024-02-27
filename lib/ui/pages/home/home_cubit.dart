import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_navigator.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;

  HomeCubit({
    required this.navigator,
  }) : super(const HomeState());
}
