import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';

class CourseCardDecorations extends StatelessWidget {
  final double w;
  final double h;
  final bool isMobile;

  const CourseCardDecorations({
    super.key,
    required this.w,
    required this.h,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Top Corner Decoration
        Positioned(
          top: 0,
          left: 0,
          child: ClipRect(
            child: Align(
              alignment: Alignment.bottomRight,
              widthFactor: 0.7,
              heightFactor: 0.88,
              child: SizedBox(
                width: h * (isMobile ? 0.66 : 0.55),
                height: h * (isMobile ? 0.66 : 0.55),
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(AppImages.imagesCourseCardTopCorner),
                ),
              ),
            ),
          ),
        ),

        /// Bottom Corner Decoration
        Positioned(
          bottom: 0,
          right: 0,
          child: IgnorePointer(
            child: SvgPicture.asset(
              AppImages.imagesCourseCardBottomCorner,
              width: w * 0.5,
              height: h * (isMobile ? 0.45 : 0.4),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}