import 'package:flutter/material.dart';
import 'package:flutter_base/generated/l10n.dart';

enum ProfileMenu {
  changePassword(
    name: "Change password",
    icon: Icons.password_sharp,
    groupId: 1,
  ),
  changeEmail(
    name: "Change email",
    icon: Icons.email,
    groupId: 1,
  ),
  deleteAccount(
    name: "Delete Account",
    icon: Icons.delete,
    groupId: 1,
  ),
  openPolicy(
    name: "Term,Policy",
    icon: Icons.local_police_sharp,
    groupId: 2,
  ),
  setting(
    name: "Setting",
    icon: Icons.settings,
    groupId: 2,
  ),
  logout(
    name: "Logout",
    icon: Icons.logout,
    groupId: 2,
  );

  final String name;
  final IconData icon;
  final int groupId;

  const ProfileMenu({
    required this.name,
    required this.icon,
    required this.groupId,
  });
}

extension ProfileMenuExtension on ProfileMenu {
  static List<ProfileMenu> getAccountItems() {
    return ProfileMenu.values.where((i) => i.groupId == 1).toList();
  }

  static List<ProfileMenu> getInformationItems() {
    return ProfileMenu.values.where((i) => i.groupId == 2).toList();
  }

  static String getName({
    required ProfileMenu profileMenu,
  }) {
    switch (profileMenu.icon) {
      case Icons.password_sharp:
        return S.current.changePassword;
      case Icons.email:
        return S.current.changeEmail;
      case Icons.delete:
        return S.current.deleteAccount;
      case Icons.local_police_sharp:
        return S.current.termpolicy;
      case Icons.settings:
        return S.current.setting;
      case Icons.logout:
        return S.current.logout;
    }
    return S.current.button_next;
  }
}
