import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final String param;
  final VoidCallback? onPressed;

  const CustomWidget({
    Key? key,
    required this.param,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}