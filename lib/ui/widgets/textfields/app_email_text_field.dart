import 'package:flutter/material.dart';
import 'package:flutter_base/utils/utils.dart';

class AppEmailTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;

  // final GlobalKey<FormState> formKey;

  const AppEmailTextField({
    super.key,
    // required this.formKey,
    required this.textEditingController,
    this.onChanged,
    this.labelText = "Email",
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
            return 'Please enter email';
          }
          if (!Utils.isEmail(value)) {
            return "Email invalid";
          }
          return null;
        },
        // style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
