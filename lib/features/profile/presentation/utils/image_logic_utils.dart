import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageLogicUtils {
  static Future<XFile> convertToXFile({
    required CroppedFile croppedFile,
    required String originalName,
  }) async {
    if (kIsWeb) {
      final bytes = await croppedFile.readAsBytes();
      return XFile.fromData(
        bytes,
        path: croppedFile.path,
        name: originalName,
      );
    } else {
      return XFile(
        croppedFile.path,
        name: originalName,
      );
    }
  }
}
