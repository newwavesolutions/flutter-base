import 'package:flutter/material.dart';

class CustomBottomNavigationItem extends BottomNavigationBarItem {
  final bool isActive;

  CustomBottomNavigationItem({
    required super.icon,
    required super.label,
    this.isActive = false,
  });
}
