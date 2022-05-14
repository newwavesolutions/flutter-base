import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';

class MovieWidget extends StatelessWidget {
  final MovieEntity? movie;
  final VoidCallback? onPressed;

  const MovieWidget({
    Key? key,
    this.movie,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: _buildThumbWidget(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 32,
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(movie?.title ?? '',
                      style: theme.textTheme.caption, maxLines: 2),
                ),
              ),
              GestureDetector(
                child: const SizedBox(
                  height: 32,
                  child: Icon(
                    Icons.more_vert,
                    color: AppColors.secondary,
                    size: 16,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildThumbWidget() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: AppColors.imageBG,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: AppCacheImage(
          url: movie?.posterUrl ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
