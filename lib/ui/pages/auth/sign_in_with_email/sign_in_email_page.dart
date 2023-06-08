import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/input/app_label_text_field.dart';
import 'package:flutter_base/ui/widgets/input/app_password_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_email_cubit.dart';

class SignInEmailPage extends StatelessWidget {
  const SignInEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        return SignInCubit();
      },
      child: const SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({Key? key}) : super(key: key);

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;

  late ObscureTextController obscurePasswordController;

  late SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    usernameTextController = TextEditingController(text: 'hungtk@newwave.vn');
    passwordTextController = TextEditingController(text: "123456");
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lets Sign you in",
              style: AppTextStyle.blackS36W800,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Welcome Back ,You have been missed",
              style: AppTextStyle.blackS28,
            ),
            const SizedBox(
              height: 55,
            ),
            AppLabelTextField(
              textEditingController: usernameTextController,
              highlightText: '',
            ),
            AppPasswordInput(
              textEditingController: passwordTextController,
              obscureTextController: obscurePasswordController,
              highlightText: '',
            ),
            Row(
              children: [
                const Spacer(),
                Text(
                  "Forgot Password ?",
                  style: AppTextStyle.blackS16,
                )
              ],
            ),
            const SizedBox(height: 25),
            _buildSignButton(),
            _buildAnotherLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return AppButton(
          title: S.of(context).button_signIn,
          backgroundColor: Colors.black,
          textStyle: AppTextStyle.whiteS18,
          onPressed: _signIn,
          isLoading: state.signInStatus == LoadStatus.loading,
        );
      },
    );
  }

  Widget _buildAnotherLogin() {
    return Column(
      children: [
        const SizedBox(
          height: 19,
        ),
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: Colors.black,
                indent: 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Text(
                'or',
                style: AppTextStyle.blackS18W800,
              ),
            ),
            const Expanded(
              child: Divider(
                color: Colors.black,
                indent: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/706px-Google_%22G%22_Logo.svg.png",
              width: 28,
              height: 28,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/1200px-Facebook_Logo_%282019%29.png",
              width: 28,
              height: 28,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/1667px-Apple_logo_black.svg.png",
              width: 23,
              height: 28,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
        const SizedBox(
          height: 48,
        ),
        RichText(
          text: TextSpan(
            style: AppTextStyle.blackS16,
            children: <TextSpan>[
              const TextSpan(text: "Don’t have an account ?"),
              TextSpan(
                text: "Register Now",
                style: AppTextStyle.blackS16W800,
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _signIn() {
    _cubit.signIn();
  }
}
