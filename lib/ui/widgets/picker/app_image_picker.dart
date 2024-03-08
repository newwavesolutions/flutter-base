import 'package:flutter/cupertino.dart';
import 'package:flutter_base/utils/permission_utils.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AppImagePicker {
  static Future<XFile?> getImageFromCamera(BuildContext context) async {
    final isPhotosPermissionGranted =
        await PermissionUtils.requestPhotosPermission(context);

    final isCameraPermissionGranted =
        // ignore: use_build_context_synchronously
        await PermissionUtils.requestCameraPermission(context);

    if (isCameraPermissionGranted && isPhotosPermissionGranted) {
      XFile? imageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (imageFile != null) {
        final temp = await getTemporaryDirectory();
        final savePath = '${temp.path}/${imageFile.name}.jpeg';
        final result = await FlutterImageCompress.compressAndGetFile(
          imageFile.path,
          savePath,
          quality: 80,
        );
        return result;
      }
    }
    return null;
  }

  static Future<XFile?> getImageFromGallery(BuildContext context) async {
    final isPhotosPermissionGranted =
        await PermissionUtils.requestPhotosPermission(context);

    if (isPhotosPermissionGranted) {
      final imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (imageFile != null) {
        final temp = await getTemporaryDirectory();
        final savePath = '${temp.path}/${imageFile.name}.jpeg';
        final result = await FlutterImageCompress.compressAndGetFile(
          imageFile.path,
          savePath,
          quality: 80,
        );
        return result;
      }
    }
    return null;
  }
}
