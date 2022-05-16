import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieDetailCubit();
      },
      child: const MovieDetailChildPage(),
    );
  }
}

class MovieDetailChildPage extends StatefulWidget {
  const MovieDetailChildPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailChildPage> createState() => _MovieDetailChildPageState();
}

class _MovieDetailChildPageState extends State<MovieDetailChildPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Movie detail"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
