import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController? inputController;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;

  const AppTextFieldWidget({
    Key? key,
    this.inputController,
    this.onChanged,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: inputController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        keyboardType: textInputType,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
