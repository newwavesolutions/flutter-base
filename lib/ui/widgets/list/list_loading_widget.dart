import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/loading/app_loading_indicator.dart';

class ListLoadingWidget extends StatelessWidget {
  const ListLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppCircularProgressIndicator(),
    );
  }
}
