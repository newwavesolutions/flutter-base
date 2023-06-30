import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/shimmer/app_shimmer.dart';

class LoadingMovieDetailWidget extends StatelessWidget {
  const LoadingMovieDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppShimmer(
          width: double.infinity,
          height: 500,
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: AppShimmer(
            height: 24,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: AppShimmer(
              height: 24,
            ))
      ],
    );
  }
}
