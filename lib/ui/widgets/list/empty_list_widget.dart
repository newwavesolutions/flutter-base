import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final RefreshCallback? onRefresh;

  const EmptyListWidget({
    super.key,
    this.text = 'Không có data',
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? _onRefreshData,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Text(
                text,
                style: AppTextStyle.grayS12Bold,
              ),
            ),
          );
        },
        itemCount: 1,
      ),
    );
  }

  Future<void> _onRefreshData() async {}
}
