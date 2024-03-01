import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/global_blocs/auth/auth_cubit.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/text/app_lable.dart';
import 'package:flutter_base/ui/widgets/text_field/app_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_account_cubit.dart';
import 'delete_account_navigator.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DeleteAccountCubit(
          navigator: DeleteAccountNavigator(context: context),
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
  late final DeleteAccountCubit _cubit;
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Delete Account',
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
        children: [
          AppLabel(
            text: S.current.delete_account_confirmation_title,
            margin: const EdgeInsets.only(bottom: AppDimens.paddingSmall),
          ),
          AppTextField(
            controller: passwordTextController,
          ),
          const SizedBox(height: 16),
          AppButton(
            title: 'Confirm',
            onPressed: _onDeleteAccount,
          ),
        ],
      ),
    );
  }

  void _onDeleteAccount() {
    if (passwordTextController.text.isNotEmpty) {
      context.read<AuthCubit>().signOut();
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
