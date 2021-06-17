import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/router/application.dart';
import 'package:flutter_base/router/routers.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'watchlist_tab_cubit.dart';

class WatchlistTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WatchlistTabPageState();
  }
}

class _WatchlistTabPageState extends State<WatchlistTabPage> {
  WatchlistTabCubit _cubit;

  @override
  void initState() {
    final repository = RepositoryProvider.of<AuthRepository>(context);
    _cubit = WatchlistTabCubit(repository: repository);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
    );
  }
}
