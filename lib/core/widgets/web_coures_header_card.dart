//todo shared web course details header widget used in the app
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class WebCourseHeaderCard extends StatelessWidget {
  const WebCourseHeaderCard({super.key, required this.cardModel});
  final CourseHeaderCardModel cardModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardModel.title,
                    style: AppStyles.webTitleLargeMd.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                  //AppStyles.webTitleLargeMd.copyWith(
                  //   color: AppColors.primaryLight,
                  // ),
                  const SizedBox(height: 24),
                  Text(
                    cardModel.description,
                    style: AppStyles.webLabelMd.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SvgPicture.asset(
                AppImages.imagesHeaderCard,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
