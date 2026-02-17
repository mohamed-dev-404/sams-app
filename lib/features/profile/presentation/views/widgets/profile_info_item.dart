import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class ProfileInfoItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final String value;

  const ProfileInfoItem({
    super.key,
    required this.svgPath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 28,
              child: FittedBox(
                fit: BoxFit.contain,
                child: SvgPicture.asset(
                  svgPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppStyles.mobileBodySmallSb.copyWith(
                      color: AppColors.primaryDarkHover,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        value,
                        style: AppStyles.mobileBodyXsmallRg.copyWith(
                          color: AppColors.primaryDarkHover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
