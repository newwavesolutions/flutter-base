import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

class DatePickerController extends ValueNotifier<DateTime?> {
  DatePickerController({DateTime? dateTime}) : super(dateTime);

  DateTime? get date => value;

  set date(DateTime? newDate) {
    value = newDate;
  }
}

class AppLabelDatePicker extends StatelessWidget {
  final DatePickerController? controller;
  final String dateFormat;
  final DateTime? minTime;
  final DateTime? maxTime;
  final ValueChanged<DateTime>? onChanged;

  final String labelText;
  final TextStyle? labelStyle;
  final String highlightText;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final String hintText;
  final TextStyle? hintStyle;
  final bool enabled;

  const AppLabelDatePicker({
    Key? key,
    this.dateFormat = "dd/MM/yyyy",
    this.minTime,
    this.maxTime,
    this.controller,
    this.labelText = "",
    this.labelStyle,
    this.highlightText = "*",
    this.suffixIcon,
    this.textStyle,
    this.hintText = "",
    this.hintStyle,
    this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
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
        ),
        ValueListenableBuilder(
          valueListenable: controller!,
          child: Container(),
          builder: (context, DateTime? dateTime, child) {
            String? dateString;
            if (dateTime != null) {
              dateString = AppDateUtils.toDateTimeString(dateTime);
            }
            return GestureDetector(
              onTap: () {
                _showDatePicker(context: context);
              },
              child: TextField(
                enabled: false,
                textInputAction: TextInputAction.search,
                controller: TextEditingController(text: dateString),
                style: textStyle ?? AppTextStyle.blackS16,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.textFieldEnabledBorder),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.textFieldFocusedBorder),
                  ),
                  disabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.textFieldDisabledBorder),
                  ),
                  fillColor: Colors.white,
                  hintStyle: hintStyle ?? AppTextStyle.greyS16,
                  hintText: hintText,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(top: 8, bottom: 12),
                  suffixIcon:
                      suffixIcon ?? const Icon(Icons.date_range_outlined),
                  suffixIconConstraints:
                      const BoxConstraints(maxHeight: 32, maxWidth: 32),
                ),
                cursorColor: AppColors.textFieldCursor,
              ),
            );
          },
        ),
        const SizedBox(height: 22),
      ],
    );
  }

  _showDatePicker({
    BuildContext? context,
  }) {
    if (!enabled) {
      return;
    }
    if (context == null) {
      return;
    }
    AppDialog.showDatePicker(
      context,
      maxTime: maxTime,
      minTime: minTime,
      onConfirm: (dateTime) {
        onChanged?.call(dateTime);
        controller?.date = dateTime;
      },
      currentTime: controller?.date ?? DateTime.now(),
    );
  }
}
