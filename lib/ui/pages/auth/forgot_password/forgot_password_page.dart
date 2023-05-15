import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/auth/forgot_password/forgot_password_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPasswordCubit();
      },
      child: const ForgotPasswordChildPage(),
    );
  }
}

class ForgotPasswordChildPage extends StatefulWidget {
  const ForgotPasswordChildPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordChildPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
