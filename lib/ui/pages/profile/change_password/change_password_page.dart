import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/text/app_lable.dart';
import 'package:flutter_base/ui/widgets/text_field/app_password_text_field.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_cubit.dart';
import 'change_password_navigator.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChangePasswordCubit(
          navigator: ChangePasswordNavigator(context: context),
        );
      },
      child: const DeleteConfirmationChildPage(),
    );
  }
}

class DeleteConfirmationChildPage extends StatefulWidget {
  const DeleteConfirmationChildPage({super.key});

  @override
  State<DeleteConfirmationChildPage> createState() =>
      _DeleteConfirmationChildPageState();
}

class _DeleteConfirmationChildPageState
    extends State<DeleteConfirmationChildPage> {
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
  final _formKey = GlobalKey<FormState>();

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
              if (!Utils.isPassword(value ?? '')) {
                return 'Wrong Password Format!';
              }
              return null;
            },
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLabel(
                  text: 'New Password',
                  margin: EdgeInsets.only(
                    top: AppDimens.paddingNormal,
                    bottom: AppDimens.paddingSmall,
                  ),
                ),
                AppPasswordTextField(
                  controller: _newPasswordTextController,
                  obscureTextController: _obscureNewPasswordController,
                  validator: (value) {
                    if (!Utils.isPassword(value ?? '')) {
                      return 'Wrong Password Format!';
                    }
                    return null;
                  },
                ),
                const AppLabel(
                  text: 'Confirm Password',
                  margin: EdgeInsets.only(
                    top: AppDimens.paddingNormal,
                    bottom: AppDimens.paddingSmall,
                  ),
                ),
                AppPasswordTextField(
                  controller: _confirmPasswordTextController,
                  validator: (value) {
                    if (_newPasswordTextController.text != value) {
                      return 'Password does not match!';
                    }
                    return null;
                  },
                  obscureTextController: _obscureConfirmPasswordController,
                ),
              ],
            ),
          ),
          const Spacer(),
          AppButton(
            title: 'Confirm',
            onPressed: _changePassword,
          ),
        ],
      ),
    );
  }

  void _changePassword() {
    if (!_formKey.currentState!.validate()) {
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
