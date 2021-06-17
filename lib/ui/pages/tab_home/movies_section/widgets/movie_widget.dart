import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';

import '../../../../../commons/app_colors.dart';
import '../../../../../commons/app_text_styles.dart';
import '../../../../widgets/images/app_cache_image.dart';

class MovieWidget extends StatelessWidget {
  MovieEntity movie;
  VoidCallback onPressed;

  MovieWidget({this.movie, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        padding: EdgeInsets.all(0),
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
                      child: Text(movie?.title ?? '', style: AppTextStyle.whiteS12, maxLines: 2),
                      height: 32,
                      margin: EdgeInsets.only(top: 5),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      child: Icon(Icons.more_vert, color: AppColors.buttonNormal, size: 16),
                      height: 32,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildThumbWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: AppColors.lightGray,
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
