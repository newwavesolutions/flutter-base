import 'package:flutter/material.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/auth/sign_up/sign_up_cubit.dart';
import 'package:flutter_base/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/common/logo_widget.dart';
import 'package:flutter_base/ui/widgets/text_field/app_password_text_field.dart';
import 'package:flutter_base/ui/widgets/text_field/app_text_field.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final userCubit = RepositoryProvider.of<UserCubit>(context);
        return SignUpCubit(
          navigator: SignUpNavigator(context: context),
          authRepo: authRepo,
          userRepo: userRepo,
          userCubit: userCubit,
        );
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatefulWidget {
  const SignUpChildPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpChildPageState();
  }
}

class _SignUpChildPageState extends State<SignUpChildPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameTextController;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late TextEditingController confirmPasswordTextController;
  late ObscureTextController obscurePasswordController;
  late ObscureTextController obscureConfirmPasswordController;
  late SignUpCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<SignUpCubit>(context);
    fullNameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    obscurePasswordController = ObscureTextController(obscureText: true);
    obscureConfirmPasswordController = ObscureTextController(obscureText: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBodyWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildBodyWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const ClampingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 156),
            const LogoWidget(),
            const SizedBox(height: 28),
            AppTextField(
              controller: fullNameTextController,
              hintText: S.current.sign_up_email,
              onChanged: (text) {
                _cubit.changeFullName(fullName: text);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "S.current.full_name_empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            AppTextField(
              controller: emailTextController,
              hintText: S.current.sign_up_email_hint,
              onChanged: (text) {
                _cubit.changeEmail(email: text);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "S.current.email_empty";
                }
                if (!Utils.isEmail(value)) {
                  return "S.current.email_invalid";
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            AppPasswordTextField(
              controller: passwordTextController,
              obscureTextController: obscurePasswordController,
              hintText: S.current.sign_up_password_hint,
              onChanged: (text) {
                _cubit.changePassword(password: text);
              },
            ),
            const SizedBox(height: 8),
            AppPasswordTextField(
              controller: confirmPasswordTextController,
              obscureTextController: obscurePasswordController,
              hintText: S.current.sign_up_password_confirm_hint,
              onChanged: (text) {
                _cubit.changeConfirmPassword(confirmPassword: text);
              },
            ),
            const SizedBox(height: 16),
            _buildSignUpButton(),
            const SizedBox(height: 24),
            _buildSignInWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final bool isEnable = (state.fullName ?? '').isNotEmpty &&
            (state.email ?? '').isNotEmpty &&
            (state.password ?? '').isNotEmpty &&
            (state.confirmPassword ?? '').isNotEmpty;
        return AppButton(
          isEnabled: isEnable,
          title: 'Sign Up',
          onPressed: _signUp,
          isLoading: state.signUpStatus == LoadStatus.loading,
          boxShadow: [
            if (isEnable)
              const BoxShadow(
                color: Color(0x3D40BFFF),
                blurRadius: 30,
                offset: Offset(0, 10),
                spreadRadius: 0,
              ),
          ],
        );
      },
    );
  }

  Widget _buildSignInWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.current.button_login,
        ),
        TextButton(
          onPressed: () => _cubit.navigator.openSignInPage(),
          child: Text(
            S.current.button_login,
          ),
        ),
      ],
    );
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) {
      _cubit.navigator
          .showErrorFlushbar(message: "Please enter correct information");
      return;
    }
    if (passwordTextController.text != confirmPasswordTextController.text) {
      _cubit.navigator.showErrorFlushbar(
          message: "Password and Confirm Password do not match");
      return;
    }
    _cubit.signUp();
  }
}
