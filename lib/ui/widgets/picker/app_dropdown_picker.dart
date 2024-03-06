import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class AppDropdownController extends ValueNotifier<int> {
  AppDropdownController({int position = -1}) : super(position);

  int get position => value;

  set position(int position) {
    value = position;
  }
}

class AppDropdownPicker extends StatelessWidget {
  final AppDropdownController controller;
  final List<String> options;
  final String hintText;

  const AppDropdownPicker({
    super.key,
    required this.controller,
    required this.options,
    this.hintText = "Select",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: controller,
        builder: (context, value, child) {
          return DropdownButton<String>(
            value: value == -1 ? null : options[value],
            hint: Text(
              hintText,
              style: AppTextStyle.grayS14,
            ),
            onChanged: (value) {
              if (value != null) {
                controller.position = options.indexOf(value);
              }
            },
            style: AppTextStyle.blackS14,
            isExpanded: true,
            underline: const SizedBox(),
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppTextStyle.blackS14,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
