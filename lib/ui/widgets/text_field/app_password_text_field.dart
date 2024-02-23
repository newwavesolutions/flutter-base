import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_svgs.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObscureTextController extends ValueNotifier<bool> {
  ObscureTextController({bool obscureText = true}) : super(obscureText);

  bool get date => value;

  set date(bool obscureText) {
    value = obscureText;
  }
}

class AppPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final ObscureTextController obscureTextController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final TextStyle? style;
  final EdgeInsets? padding;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final bool enablePrefixIcon;
  final bool enableSuffixIcon;

  const AppPasswordTextField({
    super.key,
    required this.controller,
    required this.obscureTextController,
    this.onFieldSubmitted,
    this.validator,
    this.onChanged,
    this.labelText = "Password",
    this.hintText,
    this.focusNode,
    this.style,
    this.padding,
    this.hintStyle,
    this.errorStyle,
    this.enablePrefixIcon = false,
    this.enableSuffixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureTextController,
      builder: (context, bool obscureText, child) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: style ?? AppTextStyle.blackS14,
          decoration: InputDecoration(
            contentPadding: padding ??
                const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            hintText: hintText,
            hintStyle: hintStyle ?? AppTextStyle.grayS14,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide:
                  const BorderSide(color: AppColors.secondary, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide:
                  const BorderSide(color: AppColors.inputBorder, width: 1.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide:
                  const BorderSide(color: AppColors.inputBorder, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(color: AppColors.error, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(color: AppColors.error, width: 1.0),
            ),
            errorStyle: errorStyle ??
                AppTextStyle.blackS12.copyWith(color: AppColors.error),
            prefixIcon:
                enablePrefixIcon ? const Icon(Icons.lock_outline) : null,
            suffixIcon: enableSuffixIcon
                ? ValueListenableBuilder(
                    valueListenable: obscureTextController,
                    child: Container(),
                    builder: (context, bool obscureText, child) {
                      return IconButton(
                        splashRadius: 24,
                        onPressed: () {
                          Future.delayed(Duration.zero, () {
                            focusNode?.unfocus();
                          });
                          obscureTextController.value = !obscureText;
                        },
                        icon: obscureText
                            ? SvgPicture.asset(AppSVGs.icEyeClosed)
                            : SvgPicture.asset(AppSVGs.icEyeOpening),
                      );
                    },
                  )
                : null,
          ),
          keyboardType: TextInputType.visiblePassword,
          onChanged: onChanged,
          obscureText: obscureTextController.value,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
        );
      },
    );
  }
}
