import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class MobileMainCard extends StatelessWidget {
  const MobileMainCard({super.key, required this.cardModel});
  final MainCardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = cardWidth * 0.4;

        return Material(
          color: Colors.transparent,
          child: Container(
            height: cardHeight,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.primaryLightHover,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                _buildMainRow(cardWidth, cardHeight),
                _buildMoreButton(cardHeight),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainRow(double cardWidth, double cardHeight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildImage(cardWidth, cardHeight),
        Expanded(child: _buildTextSection(cardWidth, cardHeight)),
      ],
    );
  }

  Widget _buildImage(double cardWidth, double cardHeight) {
    return Container(
      width: cardWidth * 0.33,
      height: cardHeight,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: SvgPicture.asset(
          cardModel.image,
          fit: BoxFit.contain,
          width: (cardWidth * 0.2).clamp(100.0, 300.0),
          height: (cardHeight * 0.9).clamp(100.0, 300.0),
        ),
      ),
    );
  }

  Widget _buildTextSection(double cardWidth, double cardHeight) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: SizedBox(
        width: cardWidth * 0.7,
        height: cardHeight * 0.8,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildText(
                text: cardModel.title,
                cardWidth: cardWidth,
                cardHeight: cardHeight,
                maxLines: 1,
                fontSizeFactor: 0.26,
                color: AppColors.primaryDarkHover,
              ),
              SizedBox(height: cardHeight * 0.1),
              _buildText(
                text: cardModel.description,
                cardWidth: cardWidth,
                cardHeight: cardHeight,
                maxLines: 2,
                fontSizeFactor: 0.18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({
    required String text,
    required double cardWidth,
    required double cardHeight,
    required int maxLines,
    required double fontSizeFactor,
    Color? color,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: cardWidth * 0.7,
        minWidth: cardWidth * 0.2,
      ),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.mobileBodySmallRg.copyWith(
          color: color ?? AppColors.primaryDark,
          fontSize: cardHeight * fontSizeFactor,
        ),
      ),
    );
  }

  Widget _buildMoreButton(double cardHeight) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: cardModel.onTap,
        splashRadius: 24,
        icon: Transform.scale(
          scale: cardHeight / 140,
          child: SvgPicture.asset(
            AppIcons.iconsMore,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
