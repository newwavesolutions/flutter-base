import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';

class MovieWidget extends StatelessWidget {
  final MovieEntity? movie;
  final VoidCallback? onPressed;

  MovieWidget({this.movie, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: TextButton(
        child: Container(
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
                      child: Text(movie?.title ?? '', style: theme.textTheme.caption, maxLines: 2),
                      height: 32,
                      margin: EdgeInsets.only(top: 5),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      child: Icon(Icons.more_vert, color: AppColors.secondary, size: 16),
                      height: 32,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildThumbWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: AppColors.imageBG,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: AppCacheImage(
          url: movie?.posterUrl ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
