import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class HomeState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? urlAvatar;

  const HomeState({this.loadDataStatus = LoadStatus.initial, this.urlAvatar});

  @override
  List<Object?> get props => [
        loadDataStatus,
        urlAvatar,
      ];

  HomeState copyWith({
    LoadStatus? loadDataStatus,
    String? urlAvatar,
  }) {
    return HomeState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      urlAvatar: urlAvatar ?? this.urlAvatar,
    );
  }
}
