import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/ui/widgets/images/app_circle_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBannerWidget extends StatelessWidget {
  final VoidCallback onAvatarPressed;

  const ProfileBannerWidget({
    super.key,
    required this.onAvatarPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildUserItem();
  }

  Widget _buildUserItem() {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (prev, current) {
        return prev.user != current.user;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppDimens.paddingNormal),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCircleAvatar(
                  size: const Size(80, 80), onPressed: onAvatarPressed),
              const SizedBox(width: AppDimens.paddingNormal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.user?.username ?? '',
                      style: AppTextStyle.blackS18W700.copyWith(),
                    ),
                    const SizedBox(height: AppDimens.paddingSmall),
                    Text(
                      state.user?.email ?? '',
                      style: AppTextStyle.blackS14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
