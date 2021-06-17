import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';

part 'watchlist_tab_state.dart';

class WatchlistTabCubit extends Cubit<WatchlistTabState> {
  AuthRepository repository;

  WatchlistTabCubit({this.repository}) : super(WatchlistTabState());

}
