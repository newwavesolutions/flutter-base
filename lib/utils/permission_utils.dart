import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestPhotosPermission(BuildContext context) async {
    final isSdkLessThan33 = Platform.isAndroid &&
        ((await DeviceInfoPlugin().androidInfo).version.sdkInt < 33);

    if (isSdkLessThan33) {
      if (context.mounted) {
        return await requestStoragePermission(context);
      }
    } else if (await Permission.photos.isGranted) {
      return true;
    } else {
      var status = await Permission.photos.request();
      if (status.isGranted || status.isLimited) {
        return true;
      } else if (status.isPermanentlyDenied) {
        if (context.mounted) {
          await showOpenAppSettingsDialog(context);
        }
      }
    }
    return false;
  }

  static Future<bool> requestStoragePermission(BuildContext context) async {
    if (await Permission.storage.isGranted) {
      return true;
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        if (context.mounted) {
          await showOpenAppSettingsDialog(context);
        }
      }
    }
    return false;
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
          await showOpenAppSettingsDialog(context);
        }
      }
    }
    return false;
  }

  static Future<void> showOpenAppSettingsDialog(BuildContext context) async {
    await showDialog(
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
