import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

class DefaultProfileIcon extends StatelessWidget {
  const DefaultProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SvgPicture.asset(
        AppIcons.iconsHomeProfileHeader,
        colorFilter: const ColorFilter.mode(
          AppColors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}