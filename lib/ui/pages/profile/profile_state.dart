import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String version;

  const ProfileState({
    this.version = 'Unknown',
  });

  @override
  List<Object?> get props => [
        version,
      ];

  ProfileState copyWith({
    String? version,
  }) {
    return ProfileState(
      version: version ?? this.version,
    );
  }
}
