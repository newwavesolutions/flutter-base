import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';

class ErrorMovieDetailWidget extends StatelessWidget {
  final Function() onPressed;

  const ErrorMovieDetailWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.bgImagePlaceholder,
            width: 300,
            height: 300,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 40,
          ),
          AppButton(
            title: "try again",
            textStyle: AppTextStyle.whiteS16,
            width: 100,
            cornerRadius: 20,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
