import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final Function(ImageSource) onSourceSelected;

  const ImageSourceBottomSheet({
    super.key,
    required this.onSourceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Profile Picture',
              style: AppStyles.mobileBodyLargeSb.copyWith(
                color: AppColors.secondaryDarkActive,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  context,
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  source: ImageSource.gallery,
                ),
                _buildSourceOption(
                  context,
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  source: ImageSource.camera,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required ImageSource source,
  }) {
    return Column(
      children: [
        IconButton(
          icon: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
            child: Icon(icon, color: AppColors.secondary, size: 30),
          ),
          onPressed: () {
            Navigator.pop(context); 
            onSourceSelected(source); 
          },
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppStyles.mobileBodySmallMd.copyWith(
            color: AppColors.secondaryDark,
          ),
        ),
      ],
    );
  }
}
