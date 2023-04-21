import 'package:flutter/material.dart';
import 'package:flutter_base/utils/logger.dart';
import 'base_page_mixin.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BasePageState<Page extends BasePage> extends State<Page>
    with BasePageMixin {
  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: onWillPop,
        child: buildPage(context),
      );

  Future<bool> onWillPop() async => true;

  @mustCallSuper
  void onInitState() {
    logger.i('Initializing state of [$runtimeType]');
  }

  @mustCallSuper
  void onDispose() {
    logger.i('Disposing [$runtimeType]');
  }

  void onError(BuildContext context, Object? error) {
    if (error == null) {
      return;
    }
  }
}
