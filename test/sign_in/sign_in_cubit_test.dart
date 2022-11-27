import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/params/sign_in_param.dart';
import 'package:flutter_base/models/response/sign_in_response.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/sign_in/sign_in_cubit.dart';
import 'package:flutter_base/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_cubit_test.mocks.dart';

@GenerateMocks([AuthRepository, UserRepository])
void main() {
  late AuthRepository authRepository;
  late UserRepository userRepository;
  late AppCubit appCubit;
  late SignInCubit cubit;

  late SignInParam param;
  late SignInResponse signInResponse;
  late UserEntity userEntity;

  setUpAll(() {
    authRepository = MockAuthRepository();
    userRepository = MockUserRepository();

    appCubit = AppCubit(
      userRepo: userRepository,
      authRepo: authRepository,
    );
    cubit = SignInCubit(
      authRepo: authRepository,
      userRepo: userRepository,
      appCubit: appCubit,
    );
  });

  group("Initialize", () {
    test("Init cubit", () {
      expect(cubit.userRepo, isA<UserRepository>());
      expect(cubit.authRepo, isA<AuthRepository>());
      expect(cubit.appCubit, isA<AppCubit>());
    });
  });

  group("Login validate", () {
    test("Validate email", () async {
      const password = "Aa@123123";
      await cubit.checkValidateAndSignIn(email: "", password: password);
      expect(cubit.state.emailValidatorError, ValidatorError.notEmpty);

      await cubit.checkValidateAndSignIn(email: "duchv", password: password);
      expect(cubit.state.emailValidatorError, ValidatorError.invalid);

      await cubit.checkValidateAndSignIn(
          email: "duchv@gmail.com", password: password);
      expect(cubit.state.emailValidatorError, null);
    });

    test("Validate validate password", () async {
      const email = "duchv@gmail.com";
      await cubit.checkValidateAndSignIn(email: email, password: "");
      expect(
          cubit.state.passwordValidatorError, PasswordValidatorError.notEmpty);

      await cubit.checkValidateAndSignIn(email: email, password: "1234");
      expect(cubit.state.passwordValidatorError,
          PasswordValidatorError.minValidate);

      await cubit.checkValidateAndSignIn(
          email: email, password: "012345678901234567890");
      expect(cubit.state.passwordValidatorError,
          PasswordValidatorError.maxValidate);

      await cubit.checkValidateAndSignIn(
          email: email, password: "Aa@34567890123456789");
      expect(cubit.state.passwordValidatorError, null);

      await cubit.checkValidateAndSignIn(email: email, password: "Aa@123123");
      expect(cubit.state.passwordValidatorError, null);
    });
  });

  group("Login", () {
    void fakeRequest({
      String? email,
      String? password,
    }) {
      param = SignInParam(
        email: email,
        password: password,
      );
      const token = "Token";

      signInResponse = SignInResponse(
        accessToken: token,
        refreshToken: "",
        expiresIn: 0,
      );
      when(authRepository.signIn(param))
          .thenAnswer((realInvocation) => Future.value(signInResponse));

      userEntity = UserEntity();
      when(userRepository.getProfile())
          .thenAnswer((realInvocation) => Future.value(userEntity));

      final tokenEntity = TokenEntity(
        accessToken: signInResponse.accessToken ?? "",
        refreshToken: signInResponse.refreshToken ?? "",
      );
      when(authRepository.getToken())
          .thenAnswer((realInvocation) => Future.value(tokenEntity));
    }

    void fakeRequestFailure({
      String? email,
      String? password,
    }) {
      param = SignInParam(
        email: email,
        password: password,
      );
      when(authRepository.signIn(param))
          .thenAnswer((realInvocation) => Future.value(null));

      when(authRepository.getToken())
          .thenAnswer((realInvocation) => Future.value(null));
    }

    test("Login success", () async {
      fakeRequest(email: "duchv@gmail.com", password: "Aa@123123");
      await cubit.signIn(param);

      expect(appCubit.state.user, userEntity);
      expect(cubit.state.signInStatus, LoadStatus.success);

      final tokenSaved = await authRepository.getToken();
      expect(tokenSaved, isInstanceOf<TokenEntity>());
      expect(tokenSaved?.accessToken, signInResponse.accessToken ?? "");
    });

    test("Login wrong email", () async {
      fakeRequestFailure(email: "duchvzzz@gmail.com", password: "Aa@123123");
      await cubit.signIn(param);
      expect(cubit.state.signInStatus, LoadStatus.failure);
      final tokenSaved = await authRepository.getToken();
      expect(tokenSaved, null);
    });

    test("Login wrong password", () async {
      fakeRequestFailure(email: "duchv@gmail.com", password: "Aa@ggggg");
      await cubit.signIn(param);
      expect(cubit.state.signInStatus, LoadStatus.failure);
      final tokenSaved = await authRepository.getToken();
      expect(tokenSaved, null);
    });
  });
}
