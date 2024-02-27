import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/global_blocs/auth/auth_cubit.dart';
import 'package:flutter_base/global_blocs/user_info/user_info_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/enums/profile_menu.dart';
import 'package:flutter_base/ui/pages/profile/profile_navigator.dart';
import 'package:flutter_base/ui/pages/profile/widgets/profile_menu_widget.dart';
import 'package:flutter_base/ui/pages/profile/widgets/profile_banner_widget.dart';
import 'package:flutter_base/ui/widgets/app_divider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileCubit(
          navigator: ProfileNavigator(context: context),
        );
      },
      child: const _ProfileTabPage(),
    );
  }
}

class _ProfileTabPage extends StatefulWidget {
  const _ProfileTabPage();

  @override
  State<_ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<_ProfileTabPage> {
  late ProfileCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (prev, current) {
            return prev.signOutStatus != current.signOutStatus;
          },
          listener: (context, state) {
            if (state.signOutStatus == LoadStatus.loading) {
              _cubit.navigator.showLoadingOverlay();
            } else if (state.signOutStatus == LoadStatus.success) {
              _cubit.navigator.hideLoadingOverlay();
              _cubit.navigator.openSignIn();
            } else if (state.signOutStatus == LoadStatus.failure) {
              _cubit.navigator.hideLoadingOverlay();
            }
          },
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<UserInfoCubit, UserInfoState>(
          builder: (context, state) {
            return ProfileBannerWidget(
              user: state.user ?? UserEntity(),
              onAvatarPressed: () {
                _cubit.navigator.openUpdateAvatar();
              },
            );
          },
        ),
        Container(height: 4, color: AppColors.divider),
        const AppDivider(),
        ProfileMenuWidget(
          menu: ProfileMenu.updateProfile,
          onMenuTapped: () {
            _onMenuTapped(ProfileMenu.updateProfile);
          },
        ),
        const AppDivider(indent: AppDimens.paddingNormal),
        ProfileMenuWidget(
          menu: ProfileMenu.changePassword,
          onMenuTapped: () {
            _onMenuTapped(ProfileMenu.changePassword);
          },
        ),
        const AppDivider(indent: AppDimens.paddingNormal),
        ProfileMenuWidget(
          menu: ProfileMenu.openPolicy,
          onMenuTapped: () {
            _onMenuTapped(ProfileMenu.openPolicy);
          },
        ),
        const AppDivider(indent: AppDimens.paddingNormal),
        ProfileMenuWidget(
          menu: ProfileMenu.logout,
          onMenuTapped: () {
            _onMenuTapped(ProfileMenu.logout);
          },
        ),
        const AppDivider(indent: AppDimens.paddingNormal),
        ProfileMenuWidget(
          menu: ProfileMenu.deleteAccount,
          onMenuTapped: () {
            _onMenuTapped(ProfileMenu.deleteAccount);
          },
        ),
      ],
    );
  }

  void _onMenuTapped(ProfileMenu menu) {
    switch (menu) {
      case ProfileMenu.updateProfile:
        _cubit.navigator.openUpdateProfile();
      case ProfileMenu.changePassword:
      // TODO: Handle this case.
      case ProfileMenu.deleteAccount:
      // TODO: Handle this case.
      case ProfileMenu.openPolicy:
      // TODO: Handle this case.
      case ProfileMenu.logout:
        context.read<AuthCubit>().signOut();
    }
  }
}
