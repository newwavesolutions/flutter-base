import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_svgs.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:flutter_base/ui/pages/auth/widgets/welcome_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/text_field/app_password_text_field.dart';
import 'package:flutter_base/ui/widgets/text_field/app_text_field.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'sign_in_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return SignInCubit(
          navigator: SignInNavigator(context: context),
          authRepo: authRepo,
          userRepo: userRepo,
          appCubit: appCubit,
        );
      },
      child: const SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({super.key});

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  late ObscureTextController obscurePasswordController;
  final _formKey = GlobalKey<FormState>();

  late SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController(text: 'mobile@newwave.com');
    passwordTextController = TextEditingController(text: "Aa@12345");
    obscurePasswordController = ObscureTextController(obscureText: true);
    _cubit = BlocProvider.of<SignInCubit>(context);
    _cubit.changeEmail(email: emailTextController.text);
    _cubit.changePassword(password: passwordTextController.text);
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
            const SizedBox(height: 112),
            WelcomeWidget(
              title: S.current.sign_in_title,
              subTitle: S.current.sign_in_sub_title,
            ),
            const SizedBox(height: 28),
            AppTextField(
              controller: emailTextController,
              hintText: S.current.your_email,
              borderRadius: 5,
              prefix: const Icon(Icons.email_outlined),
              type: TextInputType.emailAddress,
              onChanged: (text) {
                _cubit.changeEmail(email: text);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.email_empty;
                }
                if (!Utils.isEmail(value)) {
                  return "Email invalid";
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            AppPasswordTextField(
              controller: passwordTextController,
              obscureTextController: obscurePasswordController,
              hintText: S.current.password,
              borderRadius: 5,
              onChanged: (text) {
                _cubit.changePassword(password: text);
              },
            ),
            const SizedBox(height: 16),
            _buildSignInButton(),
            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 16),
            _buildSocialLoginWidget(),
            const SizedBox(height: 16),
            _buildForgotPasswordButton(),
            _buildRegisterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            S.of(context).forgot_password,
            style: AppTextStyle.primaryS12Bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final bool isEnable =
            (state.email ?? '').isNotEmpty && (state.password ?? '').isNotEmpty;
        return AppButton(
          isEnabled: isEnable,
          title: S.current.button_signIn,
          onPressed: _signIn,
          isLoading: state.signInStatus == LoadStatus.loading,
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

  Widget _buildSocialLoginWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          onPressed: () {},
          leadingIcon: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(
              AppSVGs.icGoogle,
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
          ),
          trailingIcon: const SizedBox(width: 24),
          title: S.current.login_with_google,
          textStyle: AppTextStyle.textGreyS14Bold,
          borderColor: AppColors.textGrey,
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(height: 8),
        AppButton(
          onPressed: () {},
          leadingIcon: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(
              AppSVGs.icFacebook,
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
          ),
          trailingIcon: const SizedBox(width: 24),
          title: S.current.login_with_facebook,
          textStyle: AppTextStyle.textGreyS14Bold,
          borderColor: AppColors.textGrey,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildRegisterWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.current.dont_have_an_account,
          style: AppTextStyle.textGreyS12W400,
        ),
        TextButton(
          onPressed: () => _cubit.navigator.openSignUpPage(),
          child: Text(
            S.current.register,
            style: AppTextStyle.primaryS12Bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(color: AppColors.divider),
        ),
        const SizedBox(width: 28),
        Text(
          S.current.or,
          style: AppTextStyle.textGreyS14Bold,
        ),
        const SizedBox(width: 28),
        const Expanded(
          child: Divider(color: AppColors.divider),
        ),
      ],
    );
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) {
      _cubit.navigator
          .showErrorFlushbar(message: "Please enter correct information");
      return;
    }
    _cubit.signIn();
  }
}
