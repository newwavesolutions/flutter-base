import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_list_cubit.dart';

class MovieListArguments {
  String param;

  MovieListArguments({
    required this.param,
  });
}

class MovieListPage extends StatelessWidget {
  final MovieListArguments? arguments;

  const MovieListPage({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieListCubit();
      },
      child: const MovieListChildPage(),
    );
  }
}

class MovieListChildPage extends StatefulWidget {
  const MovieListChildPage({Key? key}) : super(key: key);

  @override
  State<MovieListChildPage> createState() => _MovieListChildPageState();
}

class _MovieListChildPageState extends State<MovieListChildPage> {
  late final MovieListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
