//todo shared mobile course details header widget used in the app
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/svg_icon.dart';

class MobileCoursesHeaderCard extends StatelessWidget {
  const MobileCoursesHeaderCard({super.key, required this.cardModel});
  final CourseHeaderCardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 343 / 241,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              _buildHeaderImage(),
              _buildTextSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderText(
            text: cardModel.title,
          ),
          const SizedBox(height: 4),
          cardModel.instructor == null
              ? _buildHeaderText(
                  text: cardModel.description!,
                  style: AppStyles.mobileBodyLargeSb,
                )
              : Row(
                  children: [
                    const SvgIcon(
                      width: 19,
                      height: 19,
                      AppIcons.iconsPerson,
                      color: AppColors.whiteLight,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cardModel.instructor!,
                      style: AppStyles.mobileBodySmallRg.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeaderText({
    required String text,
    TextStyle? style,
  }) {
    return SizedBox(
      child: Text(
        text,
        style: (style ?? AppStyles.mobileTitleLargeMd).copyWith(
          color: AppColors.primaryLight,
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SvgPicture.asset(
        AppImages.imagesHeaderCard,
      ),
    );
  }
}
