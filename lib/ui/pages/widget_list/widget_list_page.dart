import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/widget_list/widgets/date_time_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget_list_cubit.dart';

class WidgetListArguments {
  String param;

  WidgetListArguments({
    required this.param,
  });
}

class WidgetListPage extends StatelessWidget {
  final WidgetListArguments? arguments;

  const WidgetListPage({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WidgetListCubit();
      },
      child: const WidgetListChildPage(),
    );
  }
}

class WidgetListChildPage extends StatefulWidget {
  const WidgetListChildPage({Key? key}) : super(key: key);

  @override
  State<WidgetListChildPage> createState() => _WidgetListChildPageState();
}

class _WidgetListChildPageState extends State<WidgetListChildPage> {
  late final WidgetListCubit _cubit;

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
        title: const Text('Widgets'),
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return ListView(
      children: [
        ListTile(
          title: const Text("DateTime"),
          onTap: _openDateTimePage,
        )
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _openDateTimePage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const DateTimePage()));
  }
}
