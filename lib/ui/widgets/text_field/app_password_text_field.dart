import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/utils/utils.dart';

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
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final TextStyle? style;
  final EdgeInsets? padding;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final TextStyle? errorStyle;

  const AppPasswordTextField({
    super.key,
    required this.controller,
    required this.obscureTextController,
    this.onChanged,
    this.labelText = "Password",
    this.hintText,
    this.focusNode,
    this.style,
    this.padding,
    this.hintStyle,
    this.borderRadius,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureTextController,
      builder: (context, bool obscureText, child) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: style ?? AppTextStyle.textGreyS12Bold,
          decoration: InputDecoration(
            contentPadding: padding ??
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            hintText: hintText,
            hintStyle: hintStyle ?? AppTextStyle.textGreyS12W400,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
            errorStyle: errorStyle ?? AppTextStyle.textFieldErrorS12Bold,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: ValueListenableBuilder(
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
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                );
              },
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          onChanged: onChanged,
          obscureText: obscureTextController.value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            }
            if (!Utils.isPassword(value)) {
              return 'Oops! Your Password Is Not Correct';
              // return "Password requires at least 8 characters, one uppercase letter, one lowercase letter, one digit, and one special character.";
            }
            return null;
          },
          // style: const TextStyle(fontSize: 16, color: Colors.black),
        );
      },
    );
  }
}
