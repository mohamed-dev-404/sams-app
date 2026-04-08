import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/validators/app_validators.dart';

/// A numeric-only text field for quiz duration (in minutes).
///
/// Features:
/// - "mins" suffix inside the field.
/// - Helper text explaining the purpose.
/// - Restricted to digits-only input.
class DurationInputField extends StatelessWidget {
  final TextEditingController controller;

  const DurationInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: AppStyles.mobileBodySmallMd.copyWith(
            color: AppColors.primaryDarkHover,
          ),
          decoration: InputDecoration(
            hintText: 'e.g. 30',
            hintStyle: AppStyles.mobileBodySmallRg.copyWith(
              color: AppColors.whiteDarkHover,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'mins',
                    style: AppStyles.mobileBodySmallMd.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 0,
              minWidth: 0,
            ),
          ),
          validator: (value) => AppValidators.validateNumber(value),
        ),
        const SizedBox(height: 6),

        // Helper subtext
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'The time limit for the student to complete the quiz',
            style: AppStyles.mobileBodyXsmallRg.copyWith(
              color: AppColors.whiteDarkActive,
            ),
          ),
        ),
      ],
    );
  }
}
