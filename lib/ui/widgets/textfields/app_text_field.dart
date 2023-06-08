import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Color? errorColor;
  final String? errorText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;

  /// properties text input password
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autoCorrect;
  final bool? isEnable;
  final String? obscuringCharacter;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLength;
  final TextStyle? counterTextStyle;
  final String? label;
  final TextStyle? labelStyle;

  const AppTextField({
    Key? key,
    this.controller,
    this.isEnable,
    this.hintText,
    this.enableBorderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.hintStyle,
    this.borderRadius,
    this.contentPadding,
    this.keyboardType,
    this.textStyle,
    this.autoCorrect,
    this.enableSuggestions,
    this.obscureText,
    this.obscuringCharacter,
    this.suffixIcon,
    this.textInputAction,
    this.errorColor,
    this.errorText,
    this.onChanged,
    this.prefixIcon,
    this.textInputFormatter,
    this.maxLength,
    this.counterTextStyle,
    this.label,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(
            label!,
            style: labelStyle ?? AppTextStyle.color10182BS14w500,
          ),
        TextFormField(
          controller: controller,
          cursorColor: cursorColor ?? AppColors.primary,
          enabled: isEnable ?? true,
          maxLength: maxLength,
          buildCounter: (
            BuildContext context, {
            int? currentLength,
            int? maxLength,
            bool? isFocused,
          }) {
            if (maxLength == null) {
              return const SizedBox();
            }
            return Text(
              "$currentLength/$maxLength",
              style: counterTextStyle,
            );
          },
          keyboardType: keyboardType ?? TextInputType.text,
          style: textStyle ?? AppTextStyle.color10182BS14w500,
          autocorrect: autoCorrect ?? true,
          enableSuggestions: false,
          obscureText: obscureText ?? false,
          inputFormatters: textInputFormatter,
          // obscuringCharacter: obscuringCharacter ?? '',
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.done,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ?? AppTextStyle.colorDarkGrayS14W400,
            errorText: errorText,
            contentPadding: contentPadding,
            isDense: true,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xffEDEDED),
            )),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.red,
            )),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            suffixIconConstraints: const BoxConstraints(maxHeight: 24),
            prefixIconConstraints: const BoxConstraints(maxHeight: 24),
          ),
        ),
      ],
    );
  }
}
