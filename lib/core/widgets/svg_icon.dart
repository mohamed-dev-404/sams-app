import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double? width;
  final double? height;

  const SvgIcon(
    this.assetName, {
    this.color = AppColors.whiteDarkHover,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,

      child: SvgPicture.asset(
        width: width,
        height: height,
        assetName,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
      ),
    );
  }
}
