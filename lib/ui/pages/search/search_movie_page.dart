import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_page.dart';
import 'package:flutter_base/ui/pages/search/widgets/search_movie_loading_widget.dart';
import 'package:flutter_base/ui/pages/search/widgets/movie_widget.dart';
import 'package:flutter_base/ui/widgets/input/app_search_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'search_movie_cubit.dart';

class SearchMoviePage extends StatelessWidget {
  const SearchMoviePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final movieRepo = RepositoryProvider.of<MovieRepository>(context);
        return SearchCubit(movieRepo: movieRepo);
      },
      child: const SearchMovieChildPage(),
    );
  }
}

class SearchMovieChildPage extends StatefulWidget {
  const SearchMovieChildPage({Key? key}) : super(key: key);

  @override
  State<SearchMovieChildPage> createState() => _SearchMovieChildPageState();
}

class _SearchMovieChildPageState extends State<SearchMovieChildPage> {
  late final SearchCubit _cubit;
  final _scrollController = ScrollController();
  late TextEditingController textSearchController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    textSearchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        elevation: 0,
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppSearchTextField(
            borderRadius: 40,
            controller: textSearchController,
            prefixIcon: InkWell(
              onTap: _search,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            suffixIcon: InkWell(
              onTap: _cleanSearch,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<SearchCubit, SearchState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.searchMovieStatus == LoadStatus.loading) {
              return Expanded(
                child: _buildLoadingList(),
              );
            } else if (state.searchMovieStatus == LoadStatus.failure) {
              return Container();
            } else {
              return Expanded(
                child: _buildSuccessList(
                  state.movies ?? [],
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildLoadingList() {
    return const SearchMovieLoadingWidget();
  }

  Widget _buildSuccessList(List<MovieEntity> items) {
    return RefreshIndicator(
      onRefresh: _onRefreshData,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          final item = items[index];
          return MovieWidget(
            movie: item,
            onPressed: () {
              Get.to(() => MovieDetailPage(movie: item));
            },
          );
        },
        itemCount: items.length,
        // controller: _scrollController,
      ),
    );
  }

  void _cleanSearch() {
    textSearchController.text = '';
    _cubit.cleanSearch();
  }

  Future<void> _search() async {
    _cubit.searchMovies(searchText: textSearchController.text);
  }

  Future<void> _onRefreshData() async {
    _cubit.searchMovies(searchText: textSearchController.text);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
