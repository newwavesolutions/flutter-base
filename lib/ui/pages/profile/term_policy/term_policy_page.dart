import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/ui/pages/profile/term_policy/term_policy_cubit.dart';
import 'package:flutter_base/ui/pages/setting/setting_cubit.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TermPolicyPage extends StatelessWidget {
  const TermPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SettingCubit();
      },
      child: const TermPolicyChildPage(),
    );
  }
}

class TermPolicyChildPage extends StatefulWidget {
  const TermPolicyChildPage({Key? key}) : super(key: key);

  @override
  State<TermPolicyChildPage> createState() => _TermPolicyChildPageState();
}

class _TermPolicyChildPageState extends State<TermPolicyChildPage> {
  late TermPolicyCubit _cubit;
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.google.com');

  @override
  void initState() {
    super.initState();
    _cubit = TermPolicyCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).settings_title,
        onBackPressed: () {
          Get.back();
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: BlocBuilder<TermPolicyCubit, TermPolicyState>(
          bloc: _cubit,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _cubit.launchInBrowser(toLaunch);
                  },
                  child: const Text('Launch in browser'),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    _cubit.launchInWebViewOrVC(toLaunch);
                  },
                  child: const Text('Launch in web view'),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    _cubit.launchInFolder();
                  },
                  child: const Text('Launch folder'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
