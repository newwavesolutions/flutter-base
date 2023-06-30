import 'package:flutter/cupertino.dart';
import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:go_router/go_router.dart';

class MoviesNavigator extends AppNavigator {
  MoviesNavigator({required BuildContext context}) : super(context: context);

  void openMovieDetail({required int id}) {
    GoRouter.of(context).pushNamed(AppRouter.movieDetail, pathParameters: {
      "id": id.toString(),
    });
  }
}
