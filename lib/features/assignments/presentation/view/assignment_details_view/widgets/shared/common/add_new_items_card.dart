import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/logic/assignment_details_handler.dart';

class AddNewItemsCard extends StatelessWidget {
  const AddNewItemsCard({super.key,required this.assignment, required this.courseId});
  final AssignmentModel assignment;
  final String courseId;


  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.primary.withValues(alpha: 0.3),
      strokeWidth: 2,
      dashPattern: const [8, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.02),
          ),
          child: InkWell(
            onTap: () => AssignmentDetailsHandler.onAddItemsCard(
              context,
              assignmentId: assignment.id,
              courseId: courseId,
              classworkId: assignment.classworkId,
            ),
            borderRadius: BorderRadius.circular(24),
            hoverColor: AppColors.primary.withValues(alpha: 0.05),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.upload_file_rounded,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Click to upload new materials',
                    style: AppStyles.mobileBodyLargeMd.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'PDF, DOCX, or Images (max. 20MB)',
                    style: AppStyles.mobileBodyXsmallRg.copyWith(
                      color: AppColors.whiteDarkActive,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}