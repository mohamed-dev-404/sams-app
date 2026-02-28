import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';

class ProfileEditButton extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileEditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile(context);
    final double buttonSize = isMobile 
        ? SizeConfig.screenWidth(context) * .10 
        : 30;

    return Positioned(
      bottom: 5,
      right: 0,
      left: isMobile ? 85 : 75,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            AppIcons.iconsEditMaterial,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteLight,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}