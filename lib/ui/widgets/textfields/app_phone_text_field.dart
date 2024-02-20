import 'package:flutter/material.dart';
import 'package:flutter_base/utils/utils.dart';

class AppPhoneTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;

  // final GlobalKey<FormState> formKey;

  const AppPhoneTextField({
    super.key,
    // required this.formKey,
    required this.textEditingController,
    this.onChanged,
    this.labelText = "Phone",
    this.hintText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        // key: formKey,
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter phone';
          }
          if (!Utils.isPhoneNumber(value)) {
            return "Phone invalid";
          }
          return null;
        },
        // style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
