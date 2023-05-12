import 'package:flutter/material.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:get/get.dart';

class AppDialog {
  static final _now = DateTime.now();
  static final _firstDateDefault =
      DateTime(_now.year - 100, _now.month, _now.day);
  static final _lastDateDefault =
      DateTime(_now.year + 100, _now.month, _now.day);
  static final _timeNow = TimeOfDay(hour: _now.hour, minute: _now.minute);

  static void defaultDialog({
    String title = "Alert",
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      onConfirm: onConfirm == null
          ? null
          : () {
              Get.back();
              onConfirm.call();
            },
      onCancel: onCancel == null
          ? null
          : () {
              Get.back();
              onCancel.call();
            },
      textConfirm: textConfirm,
      textCancel: textCancel,
    );
  }

  static Future<DateTime?> showDateDialog(
    BuildContext context, {
    DateTime? minDate,
    DateTime? maxDate,
    DateTime? currentDate,
    Locale? locale = AppConfigs.defaultLocal,
  }) {
    final firstDate = minDate ?? _firstDateDefault;
    final lastDate = maxDate ?? _lastDateDefault;
    return showDatePicker(
      context: context,
      initialDate: _now,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      locale: locale,
    );
  }

  static Future<TimeOfDay?> showTimeDialog(
    BuildContext context, {
    TimeOfDay? initialTime,
  }) {
    final initial = initialTime ?? _timeNow;
    return showTimePicker(
      context: context,
      initialTime: initial,
    );
  }
}
