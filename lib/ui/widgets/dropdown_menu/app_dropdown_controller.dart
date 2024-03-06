import 'package:flutter/foundation.dart';

class AppDropdownController extends ValueNotifier<String> {
  AppDropdownController({String? text}) : super(text ?? '');

  String get text => value;

  set text(String newText) {
    value = newText;
  }
}
