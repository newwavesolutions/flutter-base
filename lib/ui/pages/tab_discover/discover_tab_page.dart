import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';

class DiscoverTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DiscoverTabPageState();
  }
}

class _DiscoverTabPageState extends State<DiscoverTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
    );
  }
}
