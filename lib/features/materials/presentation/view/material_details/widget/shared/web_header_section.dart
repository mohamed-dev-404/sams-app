import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

//* Web header section for material details
class WebHeaderSection extends StatelessWidget {
  const WebHeaderSection({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Center(
        child: Text(
          title,
          style: AppStyles.webTitleMediumSb.copyWith(
            color: AppColors.primaryDarkHover,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
