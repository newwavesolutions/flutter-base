import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class AppLabelTextField extends StatelessWidget {
  final String labelText;
  final TextStyle? labelStyle;
  final String highlightText;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final String hintText;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final int? maxLength;

  const AppLabelTextField({
    Key? key,
    this.labelText = "",
    this.labelStyle,
    this.highlightText = "*",
    this.suffixIcon,
    this.suffixIconConstraints,
    this.textEditingController,
    this.textStyle,
    this.hintText = "",
    this.hintStyle,
    this.onChanged,
    this.onSubmitted,
    this.textInputType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: (highlightText != "" && highlightText.isNotEmpty)
              ? RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: labelText,
                      style: labelStyle ?? AppTextStyle.blackS12,
                    ),
                    TextSpan(
                      text: highlightText,
                      style: AppTextStyle.blackS12.copyWith(color: Colors.red),
                    )
                  ]),
                )
              : Text(labelText, style: labelStyle ?? AppTextStyle.blackS12),
        ),
        TextField(
          enabled: enabled,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          controller: textEditingController,
          style: textStyle ?? AppTextStyle.blackS16,
          maxLines: 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldEnabledBorder),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldFocusedBorder),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldDisabledBorder),
            ),
            fillColor: Colors.white,
            hintStyle: hintStyle ?? AppTextStyle.greyS16,
            hintText: hintText,
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 8, bottom: 12),
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints ??
                const BoxConstraints(maxHeight: 32, maxWidth: 32),
            counterText: "",
          ),
          cursorColor: AppColors.textFieldCursor,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
        ),
        textEditingController != null
            ? ValueListenableBuilder(
                valueListenable: textEditingController!,
                builder: (context, TextEditingValue controller, child) {
                  final isValid = validator?.call(controller.text) ?? "";
                  return Column(
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        isValid,
                        style:
                            AppTextStyle.blackS12.copyWith(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                },
              )
            : Container(),
      ],
    );
  }
}
