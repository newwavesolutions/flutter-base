import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/params/sign_up_param.dart';
import 'package:flutter_base/models/response/sign_up_response.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/sign_up/sign_up_cubit.dart';
import 'package:flutter_base/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_cubit_test.mocks.dart';

@GenerateMocks([AuthRepository, UserRepository])
void main() {
  late AuthRepository authRepository;
  late UserRepository userRepository;
  late AppCubit appCubit;
  late SignUpCubit cubit;

  late SignUpParam param;
  late SignUpResponse signUpResponse;
  late UserEntity userEntity;

  setUpAll(() {
    authRepository = MockAuthRepository();
    userRepository = MockUserRepository();

    appCubit = AppCubit(
      userRepo: userRepository,
      authRepo: authRepository,
    );
    cubit = SignUpCubit(
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

  group("Sign-up validate", () {
    test("Validate name", () async {
      const email = "duchv@gmail.com";
      const password = "Aa@123123";
      await cubit.checkValidate(email: email, password: password, name: '');
      expect(cubit.state.nameValidatorError, ValidatorError.notEmpty);

      await cubit.checkValidate(email: email, password: password, name: '123');
      expect(cubit.state.nameValidatorError, ValidatorError.minValidate);

      await cubit.checkValidate(
          email: email, password: password, name: '01234567890123456789');
      expect(cubit.state.nameValidatorError, null);

      await cubit.checkValidate(
          email: email, password: password, name: '012345678901234567890');
      expect(cubit.state.nameValidatorError, ValidatorError.maxValidate);
    });

    test("Validate email", () async {
      const password = "Aa@123123";
      await cubit.checkValidate(email: "", password: password, name: 'duchv');
      expect(cubit.state.emailValidatorError, ValidatorError.notEmpty);

      await cubit.checkValidate(
          email: "duchv", password: password, name: 'duchv');
      expect(cubit.state.emailValidatorError, ValidatorError.invalid);

      await cubit.checkValidate(
          email: "duchv@gmail.com", password: password, name: 'duchv');
      expect(cubit.state.emailValidatorError, null);
    });

    test("Validate password", () async {
      const email = "duchv@gmail.com";
      await cubit.checkValidate(email: email, password: "", name: 'duchv');
      expect(
          cubit.state.passwordValidatorError, PasswordValidatorError.notEmpty);

      await cubit.checkValidate(email: email, password: "1234", name: 'duchv');
      expect(cubit.state.passwordValidatorError,
          PasswordValidatorError.minValidate);

      await cubit.checkValidate(
          email: email, password: "012345678901234567890", name: 'duchv');
      expect(cubit.state.passwordValidatorError,
          PasswordValidatorError.maxValidate);

      await cubit.checkValidate(
          email: email, password: "Aa@34567890123456789", name: 'duchv');
      expect(cubit.state.passwordValidatorError, null);

      await cubit.checkValidate(
          email: email, password: "Aa@123123", name: 'duchv');
      expect(cubit.state.passwordValidatorError, null);
    });

    test("Validate all failure", () async {
      await cubit.checkValidate(email: "", password: "", name: "");
      expect(cubit.state.emailValidatorError, ValidatorError.notEmpty);
      expect(cubit.state.nameValidatorError, ValidatorError.notEmpty);
      expect(
          cubit.state.passwordValidatorError, PasswordValidatorError.notEmpty);
    });

    test("Validate all min", () async {
      const email = "duchv@gmail.com";

      await cubit.checkValidate(email: email, password: "21", name: "12");
      expect(cubit.state.nameValidatorError, ValidatorError.minValidate);
      expect(cubit.state.passwordValidatorError,
          PasswordValidatorError.minValidate);
    });

    test("Validate all max", () async {
      await cubit.checkValidate(
          email: "012345678901234567890",
          password: "012345678901234567890",
          name: "012345678901234567890");
      expect(cubit.state.emailValidatorError, ValidatorError.invalid);
      expect(cubit.state.nameValidatorError, ValidatorError.maxValidate);
      expect(cubit.state.passwordValidatorError,
          PasswordValidatorError.maxValidate);
    });
  });

  group("Sign up", () {
    void fakeRequest({
      String? name,
      String? email,
      String? password,
    }) {
      param = SignUpParam(
        name: name,
        email: email,
        password: password,
      );
      const token = "Token";

      signUpResponse = SignUpResponse(
        accessToken: token,
        refreshToken: "",
        expiresIn: 0,
      );
      when(userRepository.signUp(param))
          .thenAnswer((realInvocation) => Future.value(signUpResponse));

      userEntity = UserEntity();
      when(userRepository.getProfile())
          .thenAnswer((realInvocation) => Future.value(userEntity));

      final tokenEntity = TokenEntity(
        accessToken: signUpResponse.accessToken ?? "",
        refreshToken: signUpResponse.refreshToken ?? "",
      );
      when(authRepository.getToken())
          .thenAnswer((realInvocation) => Future.value(tokenEntity));
    }

    void fakeRequestFailure({
      String? name,
      String? email,
      String? password,
    }) {
      param = SignUpParam(
        name: name,
        email: email,
        password: password,
      );
      when(userRepository.signUp(param))
          .thenAnswer((realInvocation) => Future.value(null));

      when(authRepository.getToken())
          .thenAnswer((realInvocation) => Future.value(null));
    }

    test("Sign-up success", () async {
      fakeRequest(email: "duchv@gmail.com", password: "Aa@123123");
      await cubit.signUp(param);

      expect(appCubit.state.user, userEntity);
      expect(cubit.state.signUpStatus, LoadStatus.success);

      final tokenSaved = await authRepository.getToken();
      expect(tokenSaved, isInstanceOf<TokenEntity>());
      expect(tokenSaved?.accessToken, signUpResponse.accessToken ?? "");
    });

    test("Sign-up exist account", () async {
      // TODO: -
    });

    test("Sign-up wrong email", () async {
      fakeRequestFailure(email: "duchvzzz@gmail.com", password: "Aa@123123");
      await cubit.signUp(param);
      expect(cubit.state.signUpStatus, LoadStatus.failure);
      final tokenSaved = await authRepository.getToken();
      expect(tokenSaved, null);
    });

    test("Sign-up wrong password", () async {
      fakeRequestFailure(email: "duchv@gmail.com", password: "Aa@ggggg");
      await cubit.signUp(param);
      expect(cubit.state.signUpStatus, LoadStatus.failure);
      final tokenSaved = await authRepository.getToken();
      expect(tokenSaved, null);
    });
  });
}
