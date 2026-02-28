import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/themes/app_theme.dart';
import 'package:sams_app/features/profile/presentation/utils/image_logic_utils.dart';

abstract class ImageAcquisition {
  static Future<XFile?> pickImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: source,
    );
    if (image == null) return null;

    if (!context.mounted) return null;
    final CroppedFile? croppedFile = await _cropImage(context, image.path);
    if (croppedFile == null) return null;

    return await ImageLogicUtils.convertToXFile(
      croppedFile: croppedFile,
      originalName: image.name,
    );
  }

  static Future<CroppedFile?> _cropImage(
    BuildContext context,
    String filePath,
  ) async {
    return await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Update Profile Picture',
          toolbarColor: AppColors.secondary,
          toolbarWidgetColor: AppColors.whiteLight,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          activeControlsWidgetColor: AppColors.secondary,
          backgroundColor: AppTheme.getAppTheme().scaffoldBackgroundColor,
        ),
        IOSUiSettings(
          title: 'Update Profile Picture',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(width: 400, height: 400),
        ),
      ],
    );
  }
}
