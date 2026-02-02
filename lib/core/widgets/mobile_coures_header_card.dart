//todo shared mobile course details header widget used in the app
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class MobileCoursesHeaderCard extends StatelessWidget {
  const MobileCoursesHeaderCard({super.key, required this.cardModel});
  final CourseHeaderCardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = MediaQuery.of(context).size.height * 0.3;
        final scale = cardHeight / 280;

        return Container(
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(cardWidth * 0.06),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildTextSection(cardHeight, scale, cardWidth),
              _buildHeaderImage(cardHeight),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextSection(double cardHeight, double scale, double cardWidth) {
    return Padding(
      padding: EdgeInsets.all(cardWidth * 0.06),
      child: SizedBox(
        height: cardHeight * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(
              text: cardModel.title,
              fontSize: AppStyles.mobileTitleLargeMd.fontSize! * scale,
              height: cardHeight * 0.21,
            ),
            SizedBox(height: cardHeight * 0.02),
            _buildHeaderText(
              text: cardModel.description,
              fontSize: AppStyles.mobileBodyLargeSb.fontSize! * scale,
              height: cardHeight * 0.14,
              style: AppStyles.mobileBodyLargeSb,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText({
    required String text,
    required double fontSize,
    required double height,
    TextStyle? style,
  }) {
    return SizedBox(
      height: height,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: (style ?? AppStyles.mobileTitleLargeMd).copyWith(
            fontSize: fontSize,
            color: AppColors.primaryLight,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage(double cardHeight) {
    return Positioned(
      bottom: -cardHeight * 0.016,
      left: 0,
      right: 0,
      child: SizedBox(
        height: cardHeight * 0.55,
        child: SvgPicture.asset(
          AppImages.imagesHeaderCard,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
