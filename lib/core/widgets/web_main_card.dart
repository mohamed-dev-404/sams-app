import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class WebMainCard extends StatelessWidget {
  const WebMainCard({super.key, required this.model});
  final MainCardModel model;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 301, maxHeight: 240),
      child: AspectRatio(
        aspectRatio: 301 / 240,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: AppColors.primaryLightHover,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = constraints.maxHeight;
                return Stack(
                  children: [
                    Positioned(
                      top: h * 0.05,
                      right: w * 0.05,
                      child: GestureDetector(
                        onTap: model.onTap,
                        child: SvgPicture.asset(
                          AppIcons.iconsMore,
                          width: w * 0.1,
                          height: h * 0.1,
                        ),
                      ),
                    ),

                    Positioned(
                      top: h * 0.05,
                      left: w * 0.2,
                      right: w * 0.2,
                      child: SvgPicture.asset(
                        width: w * 0.6,
                        height: h * 0.6,
                        model.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: h * 0.65,
                      left: w * 0.08,
                      right: w * 0.08,
                      bottom: h * 0.05,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            model.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.webBodySmallSb.copyWith(
                              color: AppColors.primaryDarkHover,
                              fontSize: w * 0.05,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            model.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.mobileBodySmallRg.copyWith(
                              color: AppColors.primaryDark,
                              fontSize: w * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
