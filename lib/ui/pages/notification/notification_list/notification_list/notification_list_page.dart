import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_list_cubit.dart';

class NotificationListArguments {
  String param;

  NotificationListArguments({
    required this.param,
  });
}

class NotificationListPage extends StatelessWidget {
  final NotificationListArguments? arguments;

  const NotificationListPage({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationListCubit();
      },
      child: const NotificationListChildPage(),
    );
  }
}

class NotificationListChildPage extends StatefulWidget {
  const NotificationListChildPage({Key? key}) : super(key: key);

  @override
  State<NotificationListChildPage> createState() =>
      _NotificationListChildPageState();
}

class _NotificationListChildPageState extends State<NotificationListChildPage> {
  late final NotificationListCubit _cubit;

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
        title: const Text('Notifications'),
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
