import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/commons/app_web_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'term_policy_cubit.dart';
import 'term_policy_navigator.dart';

class TermPolicyPage extends StatelessWidget {
  const TermPolicyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TermPolicyCubit(
          navigator: TermPolicyNavigator(context: context),
        );
      },
      child: const TermPolicyChildPage(),
    );
  }
}

class TermPolicyChildPage extends StatefulWidget {
  const TermPolicyChildPage({super.key});

  @override
  State<TermPolicyChildPage> createState() => _TermPolicyChildPageState();
}

class _TermPolicyChildPageState extends State<TermPolicyChildPage> {
  late final TermPolicyCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Term & Policy',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return const AppWebView(url: 'https://newwave.vn/vi/privacy-policy/');
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
