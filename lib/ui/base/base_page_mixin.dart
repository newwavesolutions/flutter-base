import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin BasePageMixin {
  Widget buildBody(BuildContext context);

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  Widget? buildBottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget? buildBottomSheet(BuildContext context) {
    return null;
  }

  Widget? buildDrawer(BuildContext context) {
    return null;
  }

  Widget? buildEndDrawer(BuildContext context) {
    return null;
  }

  Widget? buildFloatActionButton(BuildContext context) {
    return null;
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildBody(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      bottomSheet: buildBottomSheet(context),
      drawer: buildDrawer(context),
      endDrawer: buildEndDrawer(context),
      floatingActionButton: buildFloatActionButton(context),
    );
  }

  bool get resizeToAvoidBottomInset => false;
}
