import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:get/get.dart';

class SplashState extends Equatable {
  final LoadStatus fetchProfileStatus;

  SplashState({
    this.fetchProfileStatus = LoadStatus.initial,
  });

  SplashState copyWith({
    LoadStatus? fetchProfileStatus,
  }) {
    return SplashState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
    );
  }

  @override
  List<Object?> get props => [
        fetchProfileStatus,
      ];
}
