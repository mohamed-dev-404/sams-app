import 'package:flutter/material.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_button.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';

class AssignmentStudentActionCard extends StatelessWidget {
  const AssignmentStudentActionCard({
    super.key,
    required this.onUploadPressed,
    required this.assignment,
  });

  final VoidCallback onUploadPressed;
  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    final bool isSubmitted = assignment.status == AssignmentStatus.handedIn;
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSubmitted
            ? AppColors.greenLight.withValues(alpha: 0.1)
            : AppColors.primaryLight.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSubmitted
              ? AppColors.greenLightActive
              : AppColors.primaryLightActive,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isSubmitted
                ? Icons.check_circle_rounded
                : Icons.cloud_upload_outlined,
            color: isSubmitted ? AppColors.green : AppColors.primary,
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            isSubmitted ? 'Assignment Submitted' : 'Submit Your Work',
            style: AppStyles.mobileBodyLargeSb.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isSubmitted
                ? 'You have successfully submitted your work. You can update it before the deadline.'
                : 'Upload your solution files below. Make sure to follow the instructions.',
            textAlign: TextAlign.center,
            style: AppStyles.mobileBodyXsmallRg.copyWith(
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            model: AppButtonStyleModel(
              label: isSubmitted ? 'Edit Submission' : 'Upload Files',
              onPressed: onUploadPressed,
              
              //isDisabled: assignment.status == AssignmentStatus.missed,
            ),
          ),
        ],
      ),
    );
  }
}
