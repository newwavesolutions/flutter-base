import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/input/app_password_input.dart';
import 'package:flutter_base/ui/widgets/input/app_phone_input.dart';
import 'package:flutter_base/ui/widgets/tabs/app_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_phone_number_cubit.dart';

class SignInPhonePage extends StatelessWidget {
  const SignInPhonePage({Key? key}) : super(key: key);

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

class _SignInChildPageState extends State<SignInChildPage>
    with TickerProviderStateMixin {
  late TextEditingController phoneTextController;
  late TabController _tapBarController;

  late SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    phoneTextController = TextEditingController(text: '911604330');
    _cubit = BlocProvider.of<SignInCubit>(context);
    _cubit.changeUsername(phoneNumber: phoneTextController.text);
    _tapBarController = TabController(length: 2, vsync: this);
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login Account',
                      style: AppTextStyle.blackS24W800,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Hello, Welcome back to your account.',
                      style: AppTextStyle.blackS16,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image.asset("assets/images/ic_avatar.png"),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            AppTabBar(
              tabController: _tapBarController,
              tabItems: const [
                "Email",
                "Phone no..",
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            Text(
              'Phone no..',
              style: AppTextStyle.blackS16,
            ),
            const SizedBox(
              height: 24,
            ),
            AppPhoneInput(
              textEditingController: phoneTextController,
              prefixIcon: const IntrinsicHeight(
                child: SizedBox(
                  width: 20,
                  child: Row(
                    children: [
                      Text('  +84 '),
                      VerticalDivider(
                        color: AppColors.textFieldEnabledBorder,
                        thickness: 1,
                        width: 9,
                      ),
                    ],
                  ),
                ),
              ),
              borderRadius: 25,
              // onChanged: ,
            ),
            const SizedBox(
              height: 43,
            ),
            _buildSignButton(),
            const SizedBox(
              height: 61,
            ),
            _buildSignInOther(),
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
          cornerRadius: 25,
          backgroundColor: AppColors.buttonPhone,
          textStyle: AppTextStyle.whiteS16,
          onPressed: _signIn,
          isLoading: state.signInStatus == LoadStatus.loading,
        );
      },
    );
  }

  Widget _buildSignInOther() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            const Expanded(
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Text(
                "Sign in with google",
                style: AppTextStyle.blackS16,
              ),
            ),
            const Expanded(
              child: Divider(
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 62,
        ),
        AppButton(
          title: 'Google',
          cornerRadius: 25,
          backgroundColor: Colors.white,
          textStyle: AppTextStyle.blackS16,
          // boxShadow: AppShadow.boxShadowButtonGoogle,
        ),
        const SizedBox(
          height: 43,
        ),
        RichText(
          text: TextSpan(
            style: AppTextStyle.blackS16,
            children: <TextSpan>[
              const TextSpan(text: "No registered yet ?"),
              TextSpan(
                text: " Create an account",
                style: AppTextStyle.amberS16,
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _signIn() async {
    await _cubit.signIn();
  }
}
