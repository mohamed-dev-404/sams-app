import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 70 / 56,
              child: SvgPicture.asset(
                iconPath,
                color: iconColor,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 3,
                  child: AutoSizeText(
                    fileName,
                    minFontSize: 8,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppStyles.mobileTitleSmallSb.copyWith(
                      color: AppColors.primaryDarkHover,
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(height: 2),
                ),
                Flexible(
                  flex: 4,
                  child: AutoSizeText(
                    description,
                    maxLines: 2,
                    minFontSize: 8,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.mobileBodySmallRg.copyWith(
                      color: AppColors.primary,
                    ),
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
