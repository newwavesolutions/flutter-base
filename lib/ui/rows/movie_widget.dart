import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';

import '../widgets/images/app_cache_image.dart';

class MovieWidget extends StatelessWidget {
  MovieEntity movie;
  VoidCallback onPressed;

  MovieWidget({this.movie, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 86,
      color: Colors.red,
      // child: FlatButton(
      //   padding: EdgeInsets.all(0),
      //   child: Container(
      //     child: Column(
      //       children: [
      //         _buildThumbWidget(),
      //         Expanded(
      //           child: Container(
      //             child: Text(movie?.title ?? '', style: TextStyle(fontSize: 14, color: Colors.black)),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //   onPressed: onPressed,
      // ),
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
        ),
      ),
    );
  }
}
