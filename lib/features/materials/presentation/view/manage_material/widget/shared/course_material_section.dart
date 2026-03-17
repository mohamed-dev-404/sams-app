import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class CourseMaterialSection extends StatelessWidget {
  const CourseMaterialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Material', style: AppStyles.mobileBodyLargeSb),
          const SizedBox(height: 20),
          _buildUploadBox(
            AppIcons.iconsVideo,
            'Videos',
            'Tap to upload videos (MP4)',
          ),
          const SizedBox(height: 16),
          _buildUploadBox(
            AppIcons.iconsPdf,
            'Documents',
            'Tap to upload documents (PDF)',
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox(String iconPath, String title, String sub) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greenLightActive),
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: AppStyles.mobileLabelMediumRg.copyWith(
              color: AppColors.blackDarker,
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          Text(
            sub,
            style: AppStyles.mobileLabelMediumRg.copyWith(
              color: AppColors.primaryDarkHover,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}