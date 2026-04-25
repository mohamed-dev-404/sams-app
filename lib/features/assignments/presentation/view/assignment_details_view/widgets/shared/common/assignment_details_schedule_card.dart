import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';

class AssignmentDetailsScheduleCard extends StatelessWidget {
  const AssignmentDetailsScheduleCard({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primaryLightActive),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTimeNode(
            'Posted on',
            assignment.formattedCreatedAt,
            StatusColors.blue,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: AppColors.primaryLightActive,
                thickness: 1.5,
              ),
            ),
          ),
          _buildTimeNode(
            'Deadline',
            assignment.formattedDueDate,
            StatusColors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeNode(String label, String time, Color color) {

   final String displayTime = time;
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppStyles.mobileBodyXsmallMd.copyWith(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          displayTime,
          style: AppStyles.mobileBodySmallSb.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }
}
