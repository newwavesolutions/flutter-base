import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/commons/app_images.dart';
import 'package:flutter_base/commons/app_text_styles.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/pages/sign_in/sign_in_cubit.dart';
import 'package:flutter_base/ui/widgets/input/app_email_input.dart';
import 'package:flutter_base/ui/widgets/input/app_password_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  final _usernameTextController = TextEditingController(text: 'thoson.it@gmail.com');
  final _passwordTextController = TextEditingController(text: "Son@1234");
  final _obscurePasswordController = ObscureTextController(obscureText: true);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  SignInCubit _cubit;

  @override
  void initState() {
    final repository = RepositoryProvider.of<AuthRepository>(context);
    _cubit = SignInCubit(repository: repository);
    super.initState();
    _cubit.listen((state) {
      if (state.signInStatus == SignInStatus.FAILURE) {
        _showMessage('Login failure');
      } else if (state.signInStatus == SignInStatus.SUCCESS) {
        Navigator.pop(context);
      } else if (state.signInStatus == SignInStatus.USERNAME_PASSWORD_INVALID) {
        _showMessage('Wrong Username or Password');
      }
    });
  }

  @override
  void dispose() {
    _cubit.close();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    _obscurePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      body: buildBodyWidget(),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBodyWidget() {
    final showingKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 100),
        Container(height: showingKeyboard ? 0 : 200, width: 200, child: Image.asset(AppImages.icLogo)),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: AppEmailInput(
            textEditingController: _usernameTextController,
            labelStyle: AppTextStyle.whiteS14Bold,
            textStyle: AppTextStyle.whiteS14,
          ),
        ),
        SizedBox(height: 12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: AppPasswordInput(
            obscureTextController: _obscurePasswordController,
            textEditingController: _passwordTextController,
            labelStyle: AppTextStyle.whiteS14Bold,
            textStyle: AppTextStyle.whiteS14,
            onChanged: (password) {
              //Todo
            },
          ),
        ),
        SizedBox(height: 32),
        _buildSignButton(),
      ],
    );
  }

  Widget _buildSignButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      cubit: _cubit,
      buildWhen: (prev, current) {
        return prev.signInStatus != current.signInStatus;
      },
      builder: (context, state) {
        final isLoading = state.signInStatus == SignInStatus.LOADING;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppWhiteButton(
            title: 'Sign In',
            onPressed: isLoading ? null : _signIn,
            isLoading: isLoading,
          ),
        );
      },
    );
  }

  void _signIn() {
    final username = _usernameTextController.text;
    final password = _passwordTextController.text;
    if (username.isEmpty) {
      _showMessage('Username is invalid');
      return;
    }
    if (password.isEmpty) {
      _showMessage('Password is invalid');
      return;
    }
    _cubit.signIn(username, password);
  }

  void _showMessage(String message) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
