import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/common/app_vectors.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

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
  late TextEditingController otpController;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: AppTextStyle.blackS24,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
      ),
      boxShadow: AppShadow.boxShadowPinPut,
      borderRadius: BorderRadius.circular(56),
    ),
  );

  late SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController(text: '123456');
    _cubit = BlocProvider.of<SignInCubit>(context);
    _cubit.changeUsername(otp: otpController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OTP",
          style: AppTextStyle.blackS24,
        ),
        elevation: 0,
      ),
      body: buildBodyWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildBodyWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: SvgPicture.asset(
              AppVectors.imgVerificationOtp,
              width: 233,
              height: 184,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            'Verification code',
            style: AppTextStyle.blackS24,
          ),
          const SizedBox(
            height: 38,
          ),
          Text(
            'We have sand  OTP code verification to your mobile no ',
            style: AppTextStyle.blackS16,
          ),
          const SizedBox(
            height: 70,
          ),
          Text(
            widget.phone,
            style: AppTextStyle.blackS18,
          ),
          const SizedBox(
            height: 70,
          ),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            controller: otpController,
            onChanged: (value) {
              _cubit.changeUsername(otp: value);
            },
          ),
          const SizedBox(
            height: 111,
          ),
          _buildSignButton(verificationId: widget.verificationId),
        ],
      ),
    );
  }

  Widget _buildSignButton({required String verificationId}) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return AppButton(
          title: S.of(context).button_signIn,
          onPressed: () {
            _cubit.signIn(verificationId: verificationId);
          },
          cornerRadius: 25,
          backgroundColor: AppColors.buttonPhone,
          textStyle: AppTextStyle.whiteS16,
          isLoading: state.signInStatus == LoadStatus.loading,
        );
      },
    );
  }
}
