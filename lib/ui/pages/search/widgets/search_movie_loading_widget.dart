import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/shimmer/app_shimmer.dart';

class SearchMovieLoadingWidget extends StatelessWidget {
  final double rowHeight;

  const SearchMovieLoadingWidget({Key? key, this.rowHeight = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppShimmer(
                width: 120,
                height: 170,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmer(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppShimmer(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppShimmer(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppShimmer(
                      width: MediaQuery.of(context).size.width,
                      height: 86,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
