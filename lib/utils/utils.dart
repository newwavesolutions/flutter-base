import 'dart:ui';

import 'package:get/get.dart';

class Utils {
  ///Search
  // static bool isTextContainKeyword({String text = "", String keyword = ""}) {
  //   final newText = String.fromCharCodes(replaceCodeUnits(text.codeUnits)).toLowerCase();
  //   final newKeyword = String.fromCharCodes(replaceCodeUnits(keyword.codeUnits)).toLowerCase();
  //   final isContain = newText.contains(newKeyword);
  //   return isContain;
  // }
  //
  // static launchPhoneCall({String phone}) async {
  //   try {
  //     await launch("tel:$phone");
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }
  //
  // static launchEmail({String email}) async {
  //   try {
  //     await launch(Uri(
  //       scheme: 'mailto',
  //       path: email,
  //     ).toString());
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  /// Checks if string is email.
  static bool isEmail(String email) => GetUtils.isEmail(email);

  /// Checks if string is phone number.
  static bool isPhoneNumber(String email) => GetUtils.isPhoneNumber(email);

  /// Checks if string is URL.
  static bool isURL(String url) => GetUtils.isURL(url);

  ///Color
  static Color? getColorFromHex(String? hexColor) {
    hexColor = (hexColor ?? '').replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  static String? getHexFromColor(Color color) {
    String colorString = color.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0];
    return valueString;
  }
}
