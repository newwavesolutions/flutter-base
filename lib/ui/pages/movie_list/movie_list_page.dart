import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/repositories/movie_isar_repository.dart';
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
        final repo = RepositoryProvider.of<MovieIsarRepository>(context);
        return MovieListCubit(movieIsarRepository: repo);
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
    // _cubit.addMovie();
    _cubit.getData();
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
    return BlocBuilder<MovieListCubit, MovieListState>(
      buildWhen: (previous, current) =>
          previous.loadDataStatus != current.loadDataStatus,
      bloc: _cubit,
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shrinkWrap: true,
          itemCount: state.listMovie?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.listMovie?[index].name ?? '',
                  style: AppTextStyle.blackS18,
                ),
                Text(
                  state.listMovie?[index].star ?? '',
                  style: AppTextStyle.blackS18,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
