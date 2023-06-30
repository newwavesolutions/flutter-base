import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/ui/widgets/images/app_circle_avatar.dart';

class UserBannerWidget extends StatelessWidget {
  final UserEntity user;
  final Function() onPressed;
  final Function() onPressedAvatar;

  const UserBannerWidget({
    Key? key,
    required this.user,
    required this.onPressed,
    required this.onPressedAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildUserItem();
  }

  Widget _buildUserItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onPressedAvatar,
          child: AppCircleAvatar(
            url: user.avatarUrl ?? '',
            size: 40,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username ?? '',
                style: AppTextStyle.blackS18W700.copyWith(),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                user.email ?? '',
                style: AppTextStyle.blackS16,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                user.phone ?? '',
                style: AppTextStyle.blackS16,
              ),
            ],
          ),
        ),
        InkWell(
            onTap: onPressed,
            child: const Icon(
              CupertinoIcons.pencil,
              size: 30,
              color: Colors.black,
            ))
      ],
    );
  }
}
