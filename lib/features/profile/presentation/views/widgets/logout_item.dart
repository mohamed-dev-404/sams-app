import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.iconsProfileLogout,
            ),
            const SizedBox(width: 16),
            Text(
              'Log Out',
              style: AppStyles.mobileBodySmallSb.copyWith(color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }
}
