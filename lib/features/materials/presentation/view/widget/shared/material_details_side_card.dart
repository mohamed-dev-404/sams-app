import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class MaterialDetailsSideCard extends StatelessWidget {
  const MaterialDetailsSideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Illustration Image
                Center(
                  child: SvgPicture.asset(
                    'assets/images/hijab_image.svg',
                    width: width * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Title and Edit Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Chapter One',
                        style: AppStyles.webTitleMediumSb.copyWith(
                          color: AppColors.primaryDarkHover,
                          fontSize: width * 0.065,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Navigate to edit material view
                      },
                      icon: SvgPicture.asset(
                        AppIcons.iconsEditMaterial,
                        width: width * 0.08,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Description text
                Text(
                  'Chapter 1: Database Fundamentals and Theories. Detailed overview of core concepts.',
                  style: AppStyles.mobileBodyLargeRg.copyWith(
                    color: AppColors.primary,
                    fontSize: width * 0.055,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}