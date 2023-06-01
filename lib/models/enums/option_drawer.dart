import 'package:flutter/material.dart';

enum OptionDrawer {
  home(
    value: "Home",
    icon: Icons.home,
  ),
  reports(
    value: "Reports",
    icon: Icons.add_chart_outlined,
  ),
  profile(
    value: "Profile",
    icon: Icons.person_pin_sharp,
  ),
  instructions(
    value: "Instructions",
    icon: Icons.menu_book,
  ),
  notification(
    value: "Notification",
    icon: Icons.add_alarm,
  ),
  game(
    value: "Game",
    icon: Icons.smart_toy_outlined,
  ),
  settings(
    value: "Settings",
    icon: Icons.settings,
  );

  final String value;
  final IconData icon;

  const OptionDrawer({
    required this.value,
    required this.icon,
  });
}
