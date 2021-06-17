part of 'splash_cubit.dart';

enum LoginState { INITIAL, LOGGED_IN, LOGGED_OUT }

class SplashState extends Equatable {
  final LoginState loginState;
  final LoadStatus loadUserStatus;
  final UserEntity user;
  final LoadStatus loadServerConfigStatus;
  final RemoteConfigEntity remoteConfig;

  SplashState({
    this.loginState = LoginState.INITIAL,
    this.loadUserStatus = LoadStatus.INITIAL,
    this.user,
    this.loadServerConfigStatus = LoadStatus.INITIAL,
    this.remoteConfig,
  });

  SplashState copyWith({
    LoginState loginState,
    LoadStatus loadUserStatus,
    UserEntity user,
    LoadStatus loadServerConfigStatus,
    RemoteConfigEntity remoteConfig,
  }) {
    return SplashState(
      loginState: loginState ?? this.loginState,
      loadUserStatus: loadUserStatus ?? this.loadUserStatus,
      user: user ?? this.user,
      loadServerConfigStatus:
          loadServerConfigStatus ?? this.loadServerConfigStatus,
      remoteConfig: remoteConfig ?? this.remoteConfig,
    );
  }

  @override
  List<Object> get props => [
        this.loginState,
        this.loadUserStatus,
        this.user,
        this.loadServerConfigStatus,
        this.remoteConfig,
      ];
}
