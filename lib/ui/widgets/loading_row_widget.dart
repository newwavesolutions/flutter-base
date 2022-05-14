import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:shimmer/shimmer.dart';

class LoadingRowWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final double height;

  static const _defaultPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 6,
  );

  const LoadingRowWidget({
    Key? key,
    this.padding,
    this.height = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = this.padding ?? _defaultPadding;
    return Container(
      height: height,
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppShadow.boxShadow),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[350]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
