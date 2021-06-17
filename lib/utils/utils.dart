import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_base/utils/replacement_map.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  ///Search
  static bool isTextContainKeyword({String text = "", String keyword = ""}) {
    final newText = String.fromCharCodes(replaceCodeUnits(text.codeUnits)).toLowerCase();
    final newKeyword = String.fromCharCodes(replaceCodeUnits(keyword.codeUnits)).toLowerCase();
    final isContain = newText.contains(newKeyword);
    return isContain;
  }

  static launchPhoneCall({String phone}) async {
    try {
      await launch("tel:$phone");
    } catch (e) {
      logger.e(e);
    }
  }

  static launchEmail({String email}) async {
    try {
      await launch(Uri(
        scheme: 'mailto',
        path: email,
      ).toString());
    } catch (e) {
      logger.e(e);
    }
  }
}
