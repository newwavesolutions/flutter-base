import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/widgets/dropdown_menu/app_dropdown_controller.dart';

class AppDropdownMenu extends StatelessWidget {
  final List<String> options;
  final TextStyle? style;
  final EdgeInsets? padding;
  final bool? isExpanded;
  final Widget? hint;
  final AppDropdownController controller;

  const AppDropdownMenu({
    super.key,
    required this.options,
    this.style,
    this.padding,
    this.isExpanded,
    this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
      ),
      child: ValueListenableBuilder<String>(
          valueListenable: controller,
          builder: (context, value, child) {
            return DropdownButton<String>(
              value: controller.text.isNotEmpty &&
                      options.contains(controller.text)
                  ? controller.text
                  : null,
              hint: hint ??
                  Text(
                    '--',
                    style: style ?? AppTextStyle.blackS14,
                  ),
              onChanged: (value) {
                controller.text = value ?? '';
              },
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
            );
          }),
    );
  }
}
