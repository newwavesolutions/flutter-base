import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/text/app_lable.dart';
import 'package:flutter_base/ui/widgets/text_field/app_password_text_field.dart';
import 'package:flutter_base/utils/app_validartor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_cubit.dart';
import 'change_password_navigator.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        return ChangePasswordCubit(
          navigator: ChangePasswordNavigator(context: context),
          authRepo: authRepo,
        );
      },
      child: const ChangePasswordChildPage(),
    );
  }
}

class ChangePasswordChildPage extends StatefulWidget {
  const ChangePasswordChildPage({super.key});

  @override
  State<ChangePasswordChildPage> createState() =>
      _ChangePasswordChildPageState();
}

class _ChangePasswordChildPageState extends State<ChangePasswordChildPage> {
  late final ChangePasswordCubit _cubit;
  final _currentPasswordTextController = TextEditingController();
  final _newPasswordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _obscureCurrentPasswordController =
      ObscureTextController(obscureText: true);
  final _obscureNewPasswordController =
      ObscureTextController(obscureText: true);
  final _obscureConfirmPasswordController =
      ObscureTextController(obscureText: true);
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmPasswordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Change Password',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLabel(
            text: 'Current Password',
            margin: EdgeInsets.only(bottom: AppDimens.paddingSmall),
          ),
          AppPasswordTextField(
            controller: _currentPasswordTextController,
            obscureTextController: _obscureCurrentPasswordController,
            validator: (value) {
              if ((value ?? '').isEmpty) {
                return 'Password is not empty!';
              }
              return null;
            },
          ),
          const AppLabel(
            text: 'New Password',
            margin: EdgeInsets.only(
              top: AppDimens.paddingNormal,
              bottom: AppDimens.paddingSmall,
            ),
          ),
          Form(
            key: _passwordFormKey,
            child: AppPasswordTextField(
              controller: _newPasswordTextController,
              obscureTextController: _obscureNewPasswordController,
              validator: (value) {
                return AppValidator.validatePassword(value);
              },
              onFieldSubmitted: (_) {
                _passwordFormKey.currentState?.validate();
              },
            ),
          ),
          const AppLabel(
            text: 'Confirm Password',
            margin: EdgeInsets.only(
              top: AppDimens.paddingNormal,
              bottom: AppDimens.paddingSmall,
            ),
          ),
          Form(
            key: _confirmPasswordFormKey,
            child: AppPasswordTextField(
              controller: _confirmPasswordTextController,
              validator: (value) {
                return AppValidator.validateConfirmPassword(
                    _newPasswordTextController.text, value);
              },
              obscureTextController: _obscureConfirmPasswordController,
              onFieldSubmitted: (_) {
                _confirmPasswordFormKey.currentState?.validate();
              },
            ),
          ),
          const Spacer(),
          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen: (previous, current) =>
                previous.changePasswordStatus != current.changePasswordStatus,
            builder: (context, state) {
              return AppButton(
                title: 'Confirm',
                isLoading: state.changePasswordStatus == LoadStatus.loading,
                onPressed: _changePassword,
              );
            },
          ),
        ],
      ),
    );
  }

  void _changePassword() {
    if (!_passwordFormKey.currentState!.validate()) {
      return;
    }
    if (!_confirmPasswordFormKey.currentState!.validate()) {
      return;
    }
    _cubit.changePassword(
      currentPassword: _currentPasswordTextController.text,
      newPassword: _newPasswordTextController.text,
      confirmPassword: _confirmPasswordTextController.text,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
