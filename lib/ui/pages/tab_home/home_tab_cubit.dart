import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  MovieRepository repository;
  final messageController = PublishSubject<String>();

  HomeTabCubit({this.repository}) : super(HomeTabState());

  @override
  Future<void> close() {
    messageController.close();
    return super.close();
  }
}
