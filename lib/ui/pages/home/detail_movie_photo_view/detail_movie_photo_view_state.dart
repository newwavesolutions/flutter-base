part of 'detail_movie_photo_view_cubit.dart';

class DetailMoviePhotoViewState extends Equatable {
  final LoadStatus loadDataStatus;

  const DetailMoviePhotoViewState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  DetailMoviePhotoViewState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return DetailMoviePhotoViewState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
