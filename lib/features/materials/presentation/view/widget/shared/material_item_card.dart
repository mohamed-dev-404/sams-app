import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

enum CourseMaterialType { pdf, video }

class MaterialItemCard extends StatelessWidget {
  final String fileName;
  final String description;
  final CourseMaterialType materialType;

  const MaterialItemCard({
    super.key,
    required this.fileName,
    required this.description,
    required this.materialType,
  });

  @override
  Widget build(BuildContext context) {
    final String iconPath = materialType == CourseMaterialType.video
        ? AppIcons.iconsVideoMaterial
        : AppIcons.iconsPdfMaterials;

    final Color iconColor = materialType == CourseMaterialType.video
        ? AppColors.primary
        : AppColors.red;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2A3A4D).withOpacity(0.19),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 44,
            height: 44,
            color: iconColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppStyles.mobileTitleSmallSb.copyWith(
                    color: AppColors.primaryDarkHover,
                  ),
                ),
                Text(
                  description,
                  style: AppStyles.mobileBodySmallRg.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
