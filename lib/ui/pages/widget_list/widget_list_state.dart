part of 'widget_list_cubit.dart';

class WidgetListState extends Equatable {
  final LoadStatus loadDataStatus;

  const WidgetListState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  WidgetListState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return WidgetListState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
