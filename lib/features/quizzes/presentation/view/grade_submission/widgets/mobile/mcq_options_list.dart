import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/submission_details_model.dart';

class McqOptionsList extends StatelessWidget {
  final List<AnswerOptionModel> options;

  const McqOptionsList({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final option = options[index];
        return _buildOptionContainer(option);
      },
    );
  }

  Widget _buildOptionContainer(AnswerOptionModel option) {
    // 1. Default colors
    Color bgColor, borderColor;
    Color textColor = AppColors.primaryDark;
    Widget? trailingIcon;

    // 2. State logic
    switch (option.state) {
      case OptionUIState.correctSelected:
        bgColor = StatusColors.green.withValues(alpha: 0.25);
        borderColor = StatusColors.green;
        trailingIcon = const Icon(
          Icons.check_circle_rounded,
          color: StatusColors.green,
          size: 20,
        );
        break;

      case OptionUIState.wrongSelected:
        bgColor = StatusColors.red.withValues(alpha: 0.2);
        borderColor = StatusColors.red;
        trailingIcon = const Icon(
          Icons.cancel_rounded,
          color: StatusColors.red,
          size: 20,
        );
        break;

      case OptionUIState.correctUnselected:
        bgColor = StatusColors.green.withValues(alpha: 0.1);
        borderColor = StatusColors.green;
        textColor = AppColors.primaryDark;
        trailingIcon = const Icon(
          Icons.check_circle_outline,
          color: StatusColors.green,
          size: 20,
        );
        break;

      case OptionUIState.unselected:
        bgColor = AppColors.whiteLight.withValues(alpha: 0.4);
        borderColor = AppColors.secondaryLightActive.withValues(alpha: 0.2);
        textColor = AppColors.whiteDarkActive.withValues(alpha: 0.5);
        trailingIcon = null;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              option.text,
              style: AppStyles.mobileBodyMediumRg.copyWith(
                color: textColor,
                fontWeight:
                    option.state == OptionUIState.correctSelected ||
                        option.state == OptionUIState.correctUnselected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ),
          trailingIcon ?? const SizedBox(),
        ],
      ),
    );
  }
}
