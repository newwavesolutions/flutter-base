import 'package:logger/logger.dart';

var logger = Logger();

///Deprecated
// var logger = _MyLogger();
// class _MyLogger {
//   /// Log a message at level verbose.
//   void v(dynamic message, {StackTrace? stackTrace}) {
//     _print("🤍 VERBOSE: $message", stackTrace: stackTrace);
//   }
//
//   /// Log a message at level debug.
//   void d(dynamic message, {StackTrace? stackTrace}) {
//     _print("💙 DEBUG: $message", stackTrace: stackTrace);
//   }
//
//   /// Log a message at level info.
//   void i(dynamic message, {StackTrace? stackTrace}) {
//     _print("💚️ INFO: $message", stackTrace: stackTrace);
//   }
//
//   /// Log a message at level warning.
//   void w(dynamic message, {StackTrace? stackTrace}) {
//     _print("💛 WARNING: $message", stackTrace: stackTrace);
//   }
//
//   /// Log a message at level error.
//   void e(dynamic message, {StackTrace? stackTrace}) {
//     _print("❤️ ERROR: $message", stackTrace: stackTrace);
//   }
//
//   void _print(dynamic message, {StackTrace? stackTrace}) {
//     if (kDebugMode) {
//       print("$message \n ${stackTrace ?? ''}");
//     }
//   }
//
//   void _log(dynamic message) {
//     if (kDebugMode) {
//       developer.log("$message");
//     }
//   }
//
//   void log(dynamic message,
//       {bool printFullText = false, StackTrace? stackTrace}) {
//     if (printFullText) {
//       _log(message);
//     } else {
//       _print(message);
//     }
//     if (stackTrace != null) {
//       _print(stackTrace);
//     }
//   }
// }
