import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_text_styles.dart';
import 'package:flutter_base/ui/widgets/separator_widget.dart';

class MenuHeaderWidget extends StatelessWidget {
  final String title;

  MenuHeaderWidget({this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title ?? "",
                style: AppTextStyle.greyS12Bold,
              ),
            ),
          ),
          SeparatorWidget(),
        ],
      ),
    );
  }
}
