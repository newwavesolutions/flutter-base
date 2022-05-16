import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';

import '../../../../widgets/shimmer/app_shimmer.dart';

class LoadingMoviesWidget extends StatelessWidget {
  final double rowHeight;

  const LoadingMoviesWidget({Key? key, this.rowHeight = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
      itemBuilder: (context, index) {
        return const AppShimmer(
          height: double.infinity,
          width: double.infinity,
          cornerRadius: 10,
        );
      },
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimens.paddingNormal,
        mainAxisSpacing: AppDimens.paddingNormal,
        childAspectRatio: 3 / 4,
      ),
    );
  }
}
