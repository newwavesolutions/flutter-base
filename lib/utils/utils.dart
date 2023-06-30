import 'dart:ui';

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
  static bool isEmail(String input) {
    // Regular expression pattern to match email addresses
    // This pattern allows for most common email address formats
    const String emailRegex =
        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    // Create a regular expression object
    final RegExp regex = RegExp(emailRegex);
    // Check if the input matches the email pattern
    return regex.hasMatch(input);
  }

  /// Checks if string is phone number.
  static bool isPhoneNumber(String input) {
    // Regular expression pattern to match phone numbers
    // This pattern allows for common phone number formats
    const String phoneRegex =
        r'^\+?(\d{1,4})?[-.\s]?(\d{1,3})[-.\s]?(\d{1,3})[-.\s]?(\d{1,9})$';
    // Create a regular expression object
    final RegExp regex = RegExp(phoneRegex);
    // Check if the input matches the phone number pattern
    return regex.hasMatch(input);
  }

  /// Checks if string is URL.
  static bool isURL(String input) {
    // Regular expression pattern to match URLs
    const String urlRegex = r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$';
    // Create a regular expression object
    final RegExp regex = RegExp(urlRegex, caseSensitive: false);
    // Check if the input matches the URL pattern
    return regex.hasMatch(input);
  }

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
