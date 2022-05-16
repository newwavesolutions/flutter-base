import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/sign_up/sign_up_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignUpCubit();
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatefulWidget {
  const SignUpChildPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpChildPageState();
  }
}

class _SignUpChildPageState extends State<SignUpChildPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('SignUp Page'),
    );
  }
}
