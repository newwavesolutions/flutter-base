import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class AppDropdownMenu extends StatelessWidget {
  final String? initialValue;
  final Function(String?) onChanged;
  final List<String> options;
  final TextStyle? style;
  final EdgeInsets? padding;
  final bool? isExpanded;
  final Widget? hint;

  const AppDropdownMenu({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.options,
    this.style,
    this.padding,
    this.isExpanded,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
      ),
      child: DropdownButton<String>(
        value: initialValue,
        hint: hint ??
            Text(
              '--',
              style: style ?? AppTextStyle.blackS14,
            ),
        onChanged: onChanged,
        style: style ?? AppTextStyle.blackS14,
        isExpanded: isExpanded ?? true,
        underline: const SizedBox(),
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: style ?? AppTextStyle.blackS14,
            ),
          );
        }).toList(),
      ),
    );
  }
}
