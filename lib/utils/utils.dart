import 'dart:ui';

import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  ///Search
  void launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmail(String emailAddress, String subject, String body) async {
    final url =
        'mailto:$emailAddress?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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

  /// Checks if string is password.
  /// r'^
  ///   (?=.*[A-Z])       // should contain at least one upper case
  ///   (?=.*[a-z])       // should contain at least one lower case
  ///   (?=.*?[0-9])      // should contain at least one digit
  ///   (?=.*?[!@#\$&*~]) // should contain at least one Special character
  ///   .{8,}             // Must be at least 8 characters in length
  /// $
  static bool isPassword(String input) {
    // Define a regular expression pattern for password validation.
    // This regex requires at least 8 characters, one uppercase letter, one lowercase letter,
    // one digit, and one special character.
    const passwordRegex =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    return RegExp(passwordRegex).hasMatch(input);
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
