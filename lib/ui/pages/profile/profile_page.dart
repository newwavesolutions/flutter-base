import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/setting/setting_page.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../widgets/images/app_circle_avatar.dart';
import 'profile_cubit.dart';
import 'widgets/menu_header_widget.dart';
import 'widgets/menu_item_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileCubit();
      },
      child: const _ProfileTabPage(),
    );
  }
}

class _ProfileTabPage extends StatefulWidget {
  const _ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<_ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<_ProfileTabPage>
    with AutomaticKeepAliveClientMixin {
  late AppCubit _appCubit;

  @override
  void initState() {
    _appCubit = BlocProvider.of<AppCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: "My Profile",
        showBackButton: false,
      ),
      body: ListView(
        children: [
          buildMenusWidget(),
          const SizedBox(height: 10),
          buildSignOutButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      // margin: EdgeInsets.all(20),
      // height: 60,
      // preferredSize: Size(double.infinity, 60),
      toolbarHeight: 56,
      leading: Container(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<AppCubit, AppState>(
          bloc: _appCubit,
          builder: (context, state) {
            return AppCircleAvatar(url: state.user?.avatarUrl ?? "", size: 48);
          },
        ),
      ),
      title: Row(
        children: [
          // AppCircleAvatar(url: state.user.value?.avatarUrl ?? "", size: 60),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<AppCubit, AppState>(
                  bloc: _appCubit,
                  builder: (context, state) {
                    return Text(
                      state.user?.username ?? "",
                    );
                  },
                ),
                const SizedBox(width: 10),
                const Text(
                  "View profile",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildMenusWidget() {
    return Column(
      children: [
        const MenuHeaderWidget(title: "Lists"),
        // MenuItemWidget(title: "Watchlist"),
        const MenuItemWidget(title: "History"),
        // MenuItemWidget(title: "Collection"),
        // MenuItemWidget(title: "Personal Lists"),
        // MenuItemWidget(title: "Reminders"),
        // MenuItemWidget(title: "Hidden Items"),
        const MenuHeaderWidget(title: "Settings"),
        // MenuItemWidget(title: "Go Premium"),
        MenuItemWidget(
          title: "Settings",
          onPressed: () {
            Get.to(() => const SettingPage());
          },
        ),
        const MenuItemWidget(title: "Help & feedback"),
        const MenuItemWidget(title: "About"),
      ],
    );
  }

  Widget buildSignOutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (prev, current) {
          return prev.signOutStatus != current.signOutStatus;
        },
        builder: (context, state) {
          return AppTintButton(
            title: 'Logout',
            isLoading: state.signOutStatus == LoadStatus.loading,
            onPressed: _handleSignOut,
          );
        },
      ),
    );
  }

  void _handleSignOut() {
    BlocProvider.of<AppCubit>(context).signOut();
  }

  @override
  bool get wantKeepAlive => true;
}
