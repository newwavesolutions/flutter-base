import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    Key? key,
    VoidCallback? onBackPressed,
    String title = "",
    List<Widget> rightActions = const [],
    bool showBackButton = true,
  }) : super(
          key: key,
          title: Text(title),
          toolbarHeight: 50,
          leading: showBackButton
              ? IconButton(
                  onPressed: onBackPressed,
                  icon: const Icon(Icons.arrow_back_ios_rounded))
              : null,
          actions: rightActions,
        );
}
