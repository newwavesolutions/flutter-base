import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class AppLabel extends StatelessWidget {
  final String? text;
  final bool showRequire;
  final EdgeInsets margin;

  const AppLabel({
    super.key,
    required this.text,
    this.showRequire = false,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RichText(
        text: TextSpan(
          text: text,
          style: AppTextStyle.blackS14Medium,
          children: <TextSpan>[
            if (showRequire)
              TextSpan(
                text: '*',
                style: AppTextStyle.blackS14Medium.copyWith(
                  color: const Color(0xFFEE3134),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
