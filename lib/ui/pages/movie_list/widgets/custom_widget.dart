import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final String param;
  final VoidCallback? onPressed;

  const CustomWidget({
    super.key,
    required this.param,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
