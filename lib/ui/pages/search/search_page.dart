import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/search/search_cubit.dart';
import 'package:flutter_base/ui/pages/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchCubit();
      },
      child: const _SearchPageChild(),
    );
  }
}

class _SearchPageChild extends StatefulWidget {
  const _SearchPageChild({Key? key}) : super(key: key);

  @override
  State<_SearchPageChild> createState() => _SearchPageChildState();
}

class _SearchPageChildState extends State<_SearchPageChild>
    with AutomaticKeepAliveClientMixin {
  late SearchCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SearchCubit>(context);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchState>(
        bloc: _cubit,
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Text((state.age ?? 0).toString()),
                Text(state.firstName ?? ''),
                Text(state.lastName ?? ''),
              ],
            ),
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: _cubit.change,
        child: Container(
          height: 50,
          width: 50,
          color: Colors.amber,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
