// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sams_app/core/utils/assets/app_icons.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/styles/app_styles.dart';

// class CourseMaterialSection extends StatelessWidget {
//   const CourseMaterialSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.secondary),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Course Material', style: AppStyles.mobileBodyLargeSb),
//           const SizedBox(height: 20),
//           _buildUploadBox(
//             AppIcons.iconsVideo,
//             'Videos',
//             'Tap to upload videos (MP4)',
//           ),
//           const SizedBox(height: 16),
//           _buildUploadBox(
//             AppIcons.iconsPdf,
//             'Documents',
//             'Tap to upload documents (PDF)',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUploadBox(String iconPath, String title, String sub) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.greenLightActive),
//         color: AppColors.secondaryLight,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           SvgPicture.asset(iconPath),
//           const SizedBox(
//             height: 16,
//           ),
//           Text(
//             title,
//             style: AppStyles.mobileLabelMediumRg.copyWith(
//               color: AppColors.blackDarker,
//             ),
//           ),
//           const SizedBox(
//             height: 12,
//           ),

//           Text(
//             sub,
//             style: AppStyles.mobileLabelMediumRg.copyWith(
//               color: AppColors.primaryDarkHover,
//             ),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
// تأكدي من عمل import لـ SizeConfig
// import 'path_to_size_config.dart';

class CourseMaterialSection extends StatelessWidget {
  const CourseMaterialSection({super.key});

  @override
  Widget build(BuildContext context) {
    // تحديد معامل التكبير: لو ويب نكبر الخط شوية (مثلاً 1.2)، لو موبايل يفضل زي ما هو (1.0)
    double scaleFactor = SizeConfig.isMobile(context) ? 1.0 : 1.2;

    return Container(
      padding: EdgeInsets.all(20 * scaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(16 * scaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Material', 
            style: AppStyles.mobileBodyLargeSb.copyWith(
              fontSize: AppStyles.mobileBodyLargeSb.fontSize! * scaleFactor,
            ),
          ),
          SizedBox(height: 20 * scaleFactor),
          _buildUploadBox(
            context,
            AppIcons.iconsVideo,
            'Videos',
            'Tap to upload videos (MP4)',
            scaleFactor,
          ),
          SizedBox(height: 16 * scaleFactor),
          _buildUploadBox(
            context,
            AppIcons.iconsPdf,
            'Documents',
            'Tap to upload documents (PDF)',
            scaleFactor,
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox(BuildContext context, String iconPath, String title, String sub, double scale) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greenLightActive),
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      child: Column(
        children: [
          // التحكم في حجم الأيقونة
          SvgPicture.asset(
            iconPath,
            width: 40 * scale,
            height: 40 * scale,
          ),
          SizedBox(height: 16 * scale),
          Text(
            title,
            style: AppStyles.mobileLabelMediumRg.copyWith(
              color: AppColors.blackDarker,
              fontSize: AppStyles.mobileLabelMediumRg.fontSize! * scale,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            sub,
            textAlign: TextAlign.center,
            style: AppStyles.mobileLabelMediumRg.copyWith(
              color: AppColors.primaryDarkHover,
              fontSize: (AppStyles.mobileLabelMediumRg.fontSize! - 2) * scale, // أصغر قليلاً من العنوان
            ),
          ),
        ],
      ),
    );
  }
}
