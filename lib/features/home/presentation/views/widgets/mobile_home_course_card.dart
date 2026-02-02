import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/data/models/home_course_model.dart';

class MobileHomeCourseCard extends StatelessWidget {
  const MobileHomeCourseCard({super.key, required this.course});
  final HomeCourseModel course;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = cardWidth * 0.35;

        return Container(
          width: double.infinity,
          height: cardHeight,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.primaryLightHover,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              _buildTitleSection(cardWidth, cardHeight),
              _buildTopCorner(cardHeight),
              _buildBottomCorner(cardHeight),
              _buildPopupMenu(cardWidth, cardHeight),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(double cardWidth, double cardHeight) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        cardWidth * 0.10,
        cardHeight * 0.27,
        cardWidth * 0.20,
        cardHeight * 0.20,
      ),
      child: SizedBox(
        width: cardWidth * 0.6,
        height: cardHeight * 0.5,
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    course.courseName,
                    style: AppStyles.mobileBodyXXlargeMd.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Text(
                    '(${course.courseCode})',
                    style: AppStyles.mobileBodyXsmallRg.copyWith(
                      color: AppColors.whiteDarkHover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.iconsPerson, width: 18, height: 18),
                  const SizedBox(width: 5),
                  Text(
                    course.instructorName,
                    style: AppStyles.mobileBodySmallRg.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopCorner(double cardHeight) {
    return Positioned(
      top: 0,
      left: 0,
      child: ClipRect(
        child: Align(
          alignment: Alignment.bottomRight,
          widthFactor: 0.7,
          heightFactor: 0.88,
          child: SizedBox(
            width: cardHeight * .66,
            height: cardHeight * .66,
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(AppImages.imagesCourseCardTopCorner),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCorner(double cardHeight) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        height: cardHeight,
        child: AspectRatio(
          aspectRatio: 1,
          child: SvgPicture.asset(
            AppImages.imagesCourseCardBottomCorner,
            fit: BoxFit.contain,
            alignment: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenu(double cardWidth, double cardHeight) {
    return Positioned(
      top: cardHeight * 0.1,
      right: cardWidth * 0.022,
      child: PopupMenuButton<int>(
        offset: Offset(cardWidth * -.07, .2 * cardHeight),
        color: AppColors.whiteLight,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onSelected: (value) {
          if (value == 0) {
            debugPrint('Edit Course');
          } else if (value == 1) {
            debugPrint('Share Course');
          }
        },
        itemBuilder: (context) => [
          _buildMenuItem(0, 'Edit', cardWidth, cardHeight),
          _buildMenuItem(1, 'Share Invitation Link', cardWidth, cardHeight),
        ],
        icon: Transform.scale(
          scale: cardHeight / 160,
          child: SvgPicture.asset(
            AppIcons.iconsMenu,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<int> _buildMenuItem(
    int value,
    String text,
    double cardWidth,
    double cardHeight,
  ) {
    return PopupMenuItem(
      value: value,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: cardWidth * 0.5),
        child: Text(
          text,
          style: AppStyles.mobileBodySmallMd.copyWith(
            color: AppColors.primaryDarkHover,
            fontSize:
                AppStyles.mobileBodySmallMd.fontSize! * (cardHeight / 100),
          ),
        ),
      ),
    );
  }
}
