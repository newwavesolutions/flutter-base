import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';

class SearchMovieEmptyWidget extends StatelessWidget {
  final String searchText;

  const SearchMovieEmptyWidget({
    Key? key,
    required this.searchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppCacheImage(
          url: '',
          width: 120,
          height: 170,
          borderRadius: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            "No results found for: $searchText",
            style: AppTextStyle.blackS16,
          ),
        ),
      ],
    );
  }
}
