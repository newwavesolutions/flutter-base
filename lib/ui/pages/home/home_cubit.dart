import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRepository _movieRepository;

  HomeCubit(this._movieRepository) : super(const HomeState());
}
