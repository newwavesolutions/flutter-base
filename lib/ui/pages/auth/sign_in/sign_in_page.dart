import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/logo/logo_widget.dart';
import 'package:flutter_base/ui/widgets/text_field/app_password_text_field.dart';
import 'package:flutter_base/ui/widgets/text_field/app_text_field.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Stack(
      children: [
        Positioned.fill(
          child: Scaffold(
            body: SafeArea(child: Container(child: buildBodyWidget())),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildRegisterWidget(),
        ),
      ],
    );
  }

  Widget buildBodyWidget() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: LogoWidget(width: 240)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingNormal),
                child: Text(
                  S.of(context).sign_in_email,
                  style: AppTextStyle.blackS14Medium,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingNormal),
                child: AppTextField(
                  controller: emailTextController,
                  hintText: S.current.sign_in_email_hint,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) {
                    _cubit.changeEmail(email: text);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email_empty";
                    }
                    if (!Utils.isEmail(value)) {
                      return "Email invalid";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingNormal),
                child: Text(
                  S.of(context).sign_in_password,
                  style: AppTextStyle.blackS14Medium,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingNormal),
                child: AppPasswordTextField(
                  controller: passwordTextController,
                  obscureTextController: obscurePasswordController,
                  hintText: S.current.sign_in_password_hint,
                  onChanged: (text) {
                    _cubit.changePassword(password: text);
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 30,
              left: AppDimens.paddingNormal,
              right: AppDimens.paddingNormal,
            ),
            decoration: BoxDecoration(
              boxShadow: AppShadow.defaultShadow,
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSignInButton(),
              ],
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final bool isEnable =
            (state.email ?? '').isNotEmpty && (state.password ?? '').isNotEmpty;
        return AppButton(
          isEnabled: isEnable,
          title: S.current.button_login,
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

  Widget _buildRegisterWidget() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => _cubit.navigator.openSignUpPage(),
            child: Text(
              S.of(context).sign_in_forgot_password,
              style: AppTextStyle.blackS12Medium,
            ),
          ),
          Container(height: 14, width: 1, color: AppColors.divider),
          TextButton(
            onPressed: () => _cubit.navigator.openSignUpPage(),
            child: Text(
              S.of(context).sign_in_register,
              style: AppTextStyle.blackS12Medium,
            ),
          ),
        ],
      ),
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
