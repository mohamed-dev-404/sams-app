import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class TitledInputField extends StatelessWidget {
  final String label;
  final Widget child;
  final double spacing;
  final TextStyle? labelStyle;

  const TitledInputField({
    super.key,
    required this.label,
    required this.child,
    this.spacing = 8.0, // Default spacing
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              labelStyle ??
              (SizeConfig.isMobile(context)
                      ? AppStyles.mobileLabelMediumMd
                      : AppStyles.webLabelMd)
                  .copyWith(
                    color: AppColors.primaryDark,
                  ),
        ),
        SizedBox(height: spacing),
        child,
      ],
    );
  }
}
