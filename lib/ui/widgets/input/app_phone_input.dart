import 'package:flutter/material.dart';
import 'package:flutter_base/utils/utils.dart';

import 'app_label_text_field.dart';

class AppPhoneInput extends AppLabelTextField {
  AppPhoneInput({
    Key? key,
    String? highlightText,
    String? labelText,
    TextStyle? labelStyle,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    Widget? prefixIcon,
    double? borderRadius,
  }) : super(
          key: key,
          prefixIcon: prefixIcon,
          borderRadius: borderRadius,
          textEditingController: textEditingController,
          onChanged: onChanged,
          labelText: labelText ?? "Số điện thoại",
          labelStyle: labelStyle,
          hintText: "",
          highlightText: highlightText ?? "*",
          textInputType: TextInputType.phone,
          enabled: enabled,
          validator: (text) {
            if (Utils.isPhoneNumber(text ?? "") || (text ?? "").isEmpty) {
              return "";
            } else {
              return "Số điện thoại không hợp lệ";
            }
          },
        );
}
