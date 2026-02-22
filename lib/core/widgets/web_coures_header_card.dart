//todo shared web course details header widget used in the app
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/svg_icon.dart';

class WebCourseHeaderCard extends StatelessWidget {
  const WebCourseHeaderCard({super.key, required this.cardModel});
  final CourseHeaderCardModel cardModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 24, top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardModel.title,
                    style: AppStyles.webTitleLargeMd.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                  SizedBox(height: 24.h),
              cardModel.description == null
                      ? const SizedBox()
                      :     Text(
                    cardModel.description!,
                    style: AppStyles.mobileBodySmallRg.copyWith(
                      color: AppColors.primaryLight,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 24.h),
                  cardModel.instructor == null
                      ? const SizedBox()
                      : Row(
                          children: [
                            const SvgIcon(
                              width: 20,
                              height: 20,
                              AppIcons.iconsPerson,
                              color: AppColors.whiteLight,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              cardModel.instructor!,
                              style: AppStyles.mobileBodyXlargeRg.copyWith(
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 80),
          Expanded(
            flex: 4,
            child: FittedBox(
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
