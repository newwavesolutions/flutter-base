import 'package:flutter/material.dart';
import 'package:flutter_base/utils/utils.dart';

class ObscureTextController extends ValueNotifier<bool> {
  ObscureTextController({bool obscureText = true}) : super(obscureText);

  bool get date => value;

  set date(bool obscureText) {
    value = obscureText;
  }
}

class AppPasswordTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ObscureTextController obscureTextController;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;

  const AppPasswordTextField({
    super.key,
    required this.textEditingController,
    required this.obscureTextController,
    this.onChanged,
    this.labelText = "Password",
    this.hintText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: obscureTextController,
          child: Container(),
          builder: (context, bool obscureText, child) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: ValueListenableBuilder(
                  valueListenable: obscureTextController,
                  child: Container(),
                  builder: (context, bool obscureText, child) {
                    return IconButton(
                      splashRadius: 24,
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          focusNode?.unfocus();
                        });
                        obscureTextController.value = !obscureText;
                      },
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    );
                  },
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              onChanged: onChanged,
              obscureText: obscureTextController.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                if (!Utils.isPassword(value)) {
                  return "Password requires at least 8 characters, one uppercase letter, one lowercase letter, one digit, and one special character.";
                }
                return null;
              },
              // style: const TextStyle(fontSize: 16, color: Colors.black),
            );
          },
        ),
      ],
    );
  }
}
