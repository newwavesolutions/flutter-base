import 'package:flutter/material.dart';
import 'package:flutter_base/utils/validators.dart';

import 'app_label_text_field.dart';

class AppEmailInput extends AppLabelTextField {
  AppEmailInput({
    String highlightText,
    TextStyle labelStyle,
    TextStyle textStyle,
    TextEditingController textEditingController,
    ValueChanged<String> onChanged,
    bool enabled = true,
  }) : super(
          textEditingController: textEditingController,
          onChanged: onChanged,
          labelText: "Email",
          labelStyle: labelStyle,
          textStyle: textStyle,
          hintText: "",
          highlightText: highlightText ?? "*",
          textInputType: TextInputType.emailAddress,
          enabled: enabled,
          validator: (text) {
            if (Validator.isValidEmail(text) || text.isEmpty) {
              return "";
            } else {
              return "Email invalid";
            }
          },
        );
}
