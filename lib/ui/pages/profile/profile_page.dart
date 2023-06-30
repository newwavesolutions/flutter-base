import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/profile_menu.dart';
import 'package:flutter_base/ui/pages/profile/profile_navigator.dart';
import 'package:flutter_base/ui/pages/profile/profile_state.dart';
import 'package:flutter_base/ui/pages/profile/widgets/profile_menu_widget.dart';
import 'package:flutter_base/ui/pages/profile/widgets/user_banner_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return ProfileCubit(
          appCubit: appCubit,
          navigator: ProfileNavigator(context: context),
        );
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

class _ProfileTabPageState extends State<_ProfileTabPage> {
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    _profileCubit = BlocProvider.of(context);
    _profileCubit.getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: UserBannerWidget(
                  user: state.user ?? UserEntity(),
                  onPressed: () {
                    _profileCubit.openUpdateProfilePage();
                  },
                  onPressedAvatar: () {
                    _profileCubit.openUpdateAvatarPage();
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 34,
              left: 20,
            ),
            child: Text(
              S.of(context).profile_text1,
              style: AppTextStyle.blackS16W600,
            ),
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return ProfileMenuWidget(
                onTap: (value) {
                  _profileCubit.handleMenuTapped(option: value);
                },
                profiles: ProfileMenuExtension.getAccountItems(),
                themeMode: state.themeMode,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 14,
              left: 20,
            ),
            child: Text(
              S.of(context).profile_text2,
              style: AppTextStyle.blackS16W600,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return ProfileMenuWidget(
                onTap: (value) {
                  _profileCubit.handleMenuTapped(option: value);
                },
                profiles: ProfileMenuExtension.getInformationItems(),
                themeMode: state.themeMode,
              );
            },
          ),
        ],
      ),
    );
  }
}
