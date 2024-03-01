import 'package:flutter/material.dart';

enum ProfileMenu {
  updateProfile(
    name: "Update Profile",
    icon: Icons.edit,
  ),
  changePassword(
    name: "Change password",
    icon: Icons.password_sharp,
  ),
  openPolicy(
    name: "Term & Policy",
    icon: Icons.local_police_sharp,
  ),
  deleteAccount(
    name: "Delete Account",
    icon: Icons.delete,
  ),
  logout(
    name: "Logout",
    icon: Icons.logout,
  );

  final String name;
  final IconData icon;

  const ProfileMenu({
    required this.name,
    required this.icon,
  });
}
