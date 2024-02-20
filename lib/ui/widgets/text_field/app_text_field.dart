import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final Icon? prefix;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? focusedColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final TextStyle? errorStyle;
  final String? Function(String?)? validator;
  final TextInputType? type;

  // final GlobalKey<FormState> formKey;

  const AppTextField({
    super.key,
    // required this.formKey,
    required this.controller,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.focusNode,
    this.prefix,
    this.hintStyle,
    this.style,
    this.focusedColor,
    this.padding,
    this.borderRadius,
    this.errorStyle,
    this.validator,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: formKey,
      controller: controller,
      focusNode: focusNode,
      style: style ?? AppTextStyle.textGreyS12Bold,
      decoration: InputDecoration(
        contentPadding:
            padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.textGreyS12W400,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        errorStyle: errorStyle ?? AppTextStyle.textFieldErrorS12Bold,
        prefixIcon: prefix,
      ),
      keyboardType: type,
      onChanged: onChanged,
      validator: validator,
      // style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}
