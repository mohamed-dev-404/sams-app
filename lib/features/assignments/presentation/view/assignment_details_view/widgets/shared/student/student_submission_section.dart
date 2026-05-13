import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/logic/assignment_details_handler.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_item_card.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_details/assignment_details_cubit.dart';

class StudentSubmissionSection extends StatelessWidget {
  final AssignmentModel assignment;
  final String courseId;

  const StudentSubmissionSection({
    super.key,
    required this.assignment,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile(context);
    final bool isSubmitted = assignment.status == AssignmentStatus.handedIn;
    final bool hasFiles = assignment.submittedItems.isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSubmitted
            ? AppColors.green.withValues(alpha: 0.05)
            : AppColors.whiteLight,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isSubmitted
              ? AppColors.green.withValues(alpha: 0.3)
              : AppColors.secondary.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                _buildStatusIcon(isSubmitted),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isSubmitted ? 'Work Handed In' : 'Your Work',
                        style: AppStyles.mobileBodyLargeSb.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        isSubmitted
                            ? 'All set! You can still refine it.'
                            : 'Missing or not submitted yet.',
                        style: AppStyles.mobileBodyXsmallRg.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton.filledTonal(
                  onPressed: () => (isMobile)
                      ? AssignmentDetailsHandler.onAddSubmissionSheet(
                          context,
                          assignment: assignment,
                          assignmentId: assignment.id,
                          courseId: courseId,
                          classworkId: assignment.classworkId,
                        )
                      : AssignmentDetailsHandler.onAddSubmissionDialog(
                          context,
                          assignment: assignment,
                          assignmentId: assignment.id,
                          courseId: courseId,
                          classworkId: assignment.classworkId,
                        ),

                  icon: Icon(
                    isSubmitted ? Icons.edit_note_rounded : Icons.add_rounded,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: isSubmitted
                        ? AppColors.green.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                    foregroundColor: isSubmitted
                        ? AppColors.green
                        : AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          if (hasFiles) ...[
            const Divider(height: 1, indent: 20, endIndent: 20),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SUBMITTED DOCUMENTS (${assignment.submittedItems.length})',
                        style: AppStyles.mobileBodyXsmallRg.copyWith(
                          color: AppColors.secondary,
                          letterSpacing: 1.2,
                          fontSize: 10,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          final cubit = context.read<AssignmentDetailsCubit>();
                          AssignmentDetailsHandler.onUnsubmitAssignment(
                            context,
                            cubit: cubit,
                            assignment: assignment,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'UNSUBMIT',
                            style: AppStyles.mobileBodySmallRg.copyWith(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...assignment.submittedItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AssignmentItemCard(
                        fileName: item.originalFileName ?? 'File',
                        description: 'submitted',
                        icon: item.icon,
                        iconColor: item.color,
                        onTap: () =>
                            AssignmentDetailsHandler.openAssignmentItem(
                              context,
                              item,
                            ),
                        onDelete: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusIcon(bool isSubmitted) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSubmitted
            ? AppColors.green
            : AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isSubmitted ? Icons.check_rounded : Icons.assignment_outlined,
        color: isSubmitted ? Colors.white : AppColors.primary,
        size: 24,
      ),
    );
  }
}
