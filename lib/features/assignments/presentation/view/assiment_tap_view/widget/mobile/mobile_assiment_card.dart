import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/assiment_model.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_card_image.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_card_style.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_status_badge.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_trailing_icon.dart';

class MobileAssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;
  final VoidCallback onTap;

  const MobileAssignmentCard({
    super.key,
    required this.assignment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = AssignmentCardStyle.fromState(assignment.state);

    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: style.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: style.borderColor, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainContent(style),
              const SizedBox(width: 12),
              AssignmentTrailingIcon(state: assignment.state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(AssignmentCardStyle style) {
    return Expanded(
      child: Row(
        children: [
          AssignmentCardImage(state: assignment.state),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  assignment.title,
                  style: AppStyles.web16Semibold.copyWith(
                    color: style.titleColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height:
                      (AppStyles.mobileBodyXsmallRg.fontSize ?? 12) *
                      (AppStyles.mobileBodyXsmallRg.height ?? 1.4) *
                      3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      assignment.description,
                      style: AppStyles.mobileBodyXsmallRg.copyWith(
                        color: style.descriptionColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AssignmentStatusBadge(
                  state: assignment.state,
                  formattedDueDate: assignment.formattedDueDate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
