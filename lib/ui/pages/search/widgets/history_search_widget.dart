import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class HistorySearchWidget extends StatelessWidget {
  final String history;
  final Function() onPressDelete;

  const HistorySearchWidget({
    Key? key,
    required this.history,
    required this.onPressDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            history,
            style: AppTextStyle.blackS16,
          ),
          InkWell(
            onTap: onPressDelete,
            child: const Icon(
              Icons.close,
              size: 12,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
