import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_svgs.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppCircleAvatar extends StatelessWidget {
  final Size size;
  final VoidCallback? onPressed;

  const AppCircleAvatar({
    super.key,
    this.size = const Size(34, 34),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (prev, current) {
        return prev.user?.avatarUrl != current.user?.avatarUrl;
      },
      builder: (context, state) {
        final avatarUrl = state.user?.avatarUrl;
        return _buildAvatar(avatarUrl: avatarUrl);
      },
    );
  }

  Widget _buildAvatar({String? avatarUrl}) {
    bool isValidUrl = Uri.tryParse(avatarUrl ?? "")?.isAbsolute == true;
    return GestureDetector(
      onTap: onPressed,
      child: ClipOval(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: AppColors.gray1,
          ),
          child: isValidUrl
              ? CachedNetworkImage(
                  imageUrl: avatarUrl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return _buildPlaceHolder();
                  },
                  fit: BoxFit.fill,
                )
              : _buildPlaceHolder(),
        ),
      ),
    );
  }

  Widget _buildPlaceHolder() {
    return SvgPicture.asset(
      AppSVGs.icAvatarPlaceholder,
      width: size.width,
      height: size.height,
    );
  }
}
