import 'package:flutter/material.dart';
import 'loading_row_widget.dart';

class LoadingListWidget extends StatelessWidget {
  const LoadingListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const LoadingRowWidget();
      },
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
