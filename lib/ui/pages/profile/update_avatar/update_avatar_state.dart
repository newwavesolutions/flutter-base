part of 'update_avatar_cubit.dart';

class UpdateAvatarState extends Equatable {
  final LoadStatus userStatus;
  final UserEntity? user;
  final File? image;
  final LoadStatus imageCollectionStatus;
  final LoadStatus imageCameraStatus;

  const UpdateAvatarState({
    this.userStatus = LoadStatus.initial,
    this.user,
    this.image,
    this.imageCollectionStatus = LoadStatus.initial,
    this.imageCameraStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        userStatus,
        user,
        image,
        imageCollectionStatus,
        imageCameraStatus,
      ];

  UpdateAvatarState copyWith({
    LoadStatus? userStatus,
    UserEntity? user,
    File? image,
    LoadStatus? imageCollectionStatus,
    LoadStatus? imageCameraStatus,
  }) {
    return UpdateAvatarState(
      userStatus: userStatus ?? this.userStatus,
      user: user ?? this.user,
      image: image ?? this.image,
      imageCollectionStatus:
          imageCollectionStatus ?? this.imageCollectionStatus,
      imageCameraStatus: imageCameraStatus ?? this.imageCameraStatus,
    );
  }
}
