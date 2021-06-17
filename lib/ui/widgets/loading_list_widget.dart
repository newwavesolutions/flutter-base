import 'package:flutter/material.dart';

import 'loading_row_widget.dart';

class LoadingListWidget extends StatelessWidget {
  final EdgeInsets rowPadding;
  final double rowHeight;

  LoadingListWidget({this.rowPadding, this.rowHeight = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return LoadingRowWidget(padding: rowPadding, height: rowHeight);
        },
        itemCount: 20,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
