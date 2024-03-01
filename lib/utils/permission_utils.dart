import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestPhotosPermission(BuildContext context) async {
    final isSdkLessThan32 = Platform.isAndroid &&
        ((await DeviceInfoPlugin().androidInfo).version.sdkInt < 33);
    if (await Permission.photos.isGranted ||
        (await Permission.storage.isGranted && isSdkLessThan32)) {
      return true;
    } else {
      var status = isSdkLessThan32
          ? await Permission.storage.request()
          : await Permission.photos.request();
      if (status.isGranted || status.isLimited) {
        return true;
      } else if (status.isPermanentlyDenied) {
        if (context.mounted) {
          showOpenAppSettingsDialog(context);
        }
      }
      return false;
    }
  }

  static Future<bool> requestCameraPermission(BuildContext context) async {
    if (await Permission.camera.isGranted) {
      return true;
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        if (context.mounted) {
          showOpenAppSettingsDialog(context);
        }
      }
      return false;
    }
  }

  static void showOpenAppSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Permission is Permanently Denied'),
          content: const Text(
            'The app needs permission access to function properly. \nPlease go to settings to grant permission.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }
}
