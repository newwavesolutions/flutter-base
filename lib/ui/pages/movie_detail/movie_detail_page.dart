import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_cubit.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieDetailCubit();
      },
      child: MovieDetailChildPage(
        movie: movie,
      ),
    );
  }
}

class MovieDetailChildPage extends StatefulWidget {
  final MovieEntity movie;

  const MovieDetailChildPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailChildPage> createState() => _MovieDetailChildPageState();
}

class _MovieDetailChildPageState extends State<MovieDetailChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.movie.title ?? '',
        onBackPressed: Get.back,
      ),
      body: const Center(
        child: Text("Movie detail"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
