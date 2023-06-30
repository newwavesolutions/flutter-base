import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/enums/profile_menu.dart';

class ProfileMenuWidget extends StatelessWidget {
  final List<ProfileMenu> profiles;
  final Function(ProfileMenu) onTap;
  final ThemeMode themeMode;

  const ProfileMenuWidget({
    Key? key,
    required this.onTap,
    required this.profiles,
    required this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: profiles.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildOptionProfileItem(
          index: index,
          context: context,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Divider(
            height: 0,
          ),
        );
      },
    );
  }

  Widget _buildOptionProfileItem(
      {required int index, required BuildContext context}) {
    return InkWell(
      onTap: () {
        onTap.call(profiles[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                profiles[index].icon,
                size: 24,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  ProfileMenuExtension.getName(profileMenu: profiles[index]),
                  style: AppTextStyle.blackS16W600.copyWith(
                    color: themeMode == ThemeMode.dark
                        ? Colors.blueAccent
                        : Colors.black,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
