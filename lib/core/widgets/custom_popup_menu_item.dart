import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class CustomPopupMenuItem extends PopupMenuItem<String> {
  CustomPopupMenuItem({
    super.key,
    required String value,
    required String title,
    required VoidCallback onTap,
  }) : super(
         value: value,
         enabled: false,
         padding: EdgeInsets.zero,
         child: InkWell(
           borderRadius: BorderRadius.circular(8),
           hoverColor: AppColors.primaryLightHover,
           onTap: onTap,
           child: Container(
             width: double.infinity,
             padding: const EdgeInsets.symmetric(
               horizontal: 12,
               vertical: 16,
             ),
             child: Text(
               title,
               style: AppStyles.mobileBodySmallMd.copyWith(
                 color: AppColors.primaryDarkHover,
               ),
             ),
           ),
         ),
       );
}
