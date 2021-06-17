part of 'watchlist_tab_cubit.dart';

class WatchlistTabState extends Equatable {
  final LoadStatus signOutStatus;

  WatchlistTabState({
    this.signOutStatus = LoadStatus.INITIAL,
  });

  WatchlistTabState copyWith({
    LoadStatus signOutStatus,
  }) {
    return WatchlistTabState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  @override
  List<Object> get props => [
        signOutStatus,
      ];
}
