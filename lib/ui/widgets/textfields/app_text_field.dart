import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final String? labelText;
  final String? hintText;

  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.textInputType,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        keyboardType: textInputType,
        onChanged: onChanged,
        // style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
