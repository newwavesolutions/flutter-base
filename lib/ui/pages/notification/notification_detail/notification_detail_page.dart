import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_detail_cubit.dart';

class NotificationDetailArguments {
  String param;

  NotificationDetailArguments({
    required this.param,
  });
}

class NotificationDetailPage extends StatelessWidget {
  final NotificationDetailArguments arguments;

  const NotificationDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationDetailCubit();
      },
      child: const NotificationDetailChildPage(),
    );
  }
}

class NotificationDetailChildPage extends StatefulWidget {
  const NotificationDetailChildPage({Key? key}) : super(key: key);

  @override
  State<NotificationDetailChildPage> createState() =>
      _NotificationDetailChildPageState();
}

class _NotificationDetailChildPageState
    extends State<NotificationDetailChildPage> {
  late final NotificationDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
