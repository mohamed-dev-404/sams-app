import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/svg_icon.dart';

class TextFieldErrorBuilder extends StatelessWidget {
  final String errorMessage;

  const TextFieldErrorBuilder({
    required this.errorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 1,
          ), // Tiny offset to align icon with first line of text
          child: SvgIcon(
            AppIcons.iconsTextFieldError,
            color: AppColors.red,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            errorMessage,
            maxLines: null,
            softWrap: true,
            textAlign: TextAlign.start,
            style:
                (SizeConfig.isMobile(context)
                        ? AppStyles.mobileBodyXsmallRg
                        : AppStyles.mobileLabelMediumRg)
                    .copyWith(
                      color: AppColors.red,
                    ),
          ),
        ),
      ],
    );
  }
}
