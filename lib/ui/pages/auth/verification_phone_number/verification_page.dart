import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_vectors.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_base/ui/widgets/input/app_password_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'verification_cubit.dart';

class VerificationPageArguments {
  final String verificationId;
  final String phone;

  VerificationPageArguments({
    required this.verificationId,
    required this.phone,
  });
}

class VerificationPage extends StatelessWidget {
  final VerificationPageArguments arguments;

  const VerificationPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        return SignInCubit();
      },
      child: VerificationChildPage(
        verificationId: arguments.verificationId,
        phone: arguments.phone,
      ),
    );
  }
}

class VerificationChildPage extends StatefulWidget {
  final String verificationId;
  final String phone;

  const VerificationChildPage({
    Key? key,
    required this.verificationId,
    required this.phone,
  }) : super(key: key);

  @override
  State<VerificationChildPage> createState() => _VerificationChildPageState();
}

class _VerificationChildPageState extends State<VerificationChildPage> {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;

  late ObscureTextController obscurePasswordController;

  late SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    usernameTextController = TextEditingController(text: 'mobile@newwave.com');
    passwordTextController = TextEditingController(text: "mobile");
    obscurePasswordController = ObscureTextController(obscureText: true);
    _cubit = BlocProvider.of<SignInCubit>(context);
    _cubit.changeUsername(username: usernameTextController.text);
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(AppVectors.imgVerificationOtp),
      ],
    );
  }

  Widget _buildSignButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppTintButton(
            title: S.of(context).button_signIn,
            onPressed: _signIn,
            isLoading: state.signInStatus == LoadStatus.loading,
          ),
        );
      },
    );
  }

  void _signIn() {
    _cubit.signIn();
  }
}
