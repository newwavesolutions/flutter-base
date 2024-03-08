part of 'update_avatar_cubit.dart';

class UpdateAvatarState extends Equatable {
  final LoadStatus userStatus;
  final UserEntity? user;
  final File? image;
  final LoadStatus updateImageStatus;

  const UpdateAvatarState({
    this.userStatus = LoadStatus.initial,
    this.user,
    this.image,
    this.updateImageStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        userStatus,
        user,
        image,
        updateImageStatus,
      ];

  UpdateAvatarState copyWith({
    LoadStatus? userStatus,
    UserEntity? user,
    File? image,
    LoadStatus? updateImageStatus,
  }) {
    return UpdateAvatarState(
      userStatus: userStatus ?? this.userStatus,
      user: user ?? this.user,
      image: image ?? this.image,
      updateImageStatus: updateImageStatus ?? this.updateImageStatus,
    );
  }
}
