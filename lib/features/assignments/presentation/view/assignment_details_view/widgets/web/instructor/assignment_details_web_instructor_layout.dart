import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/logic/assignment_details_handler.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_attached_files_grid.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_details_header.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_details_schedule_card.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_stats_row.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/instructor/assignment_actions_list.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/instructor/assignment_instructor_banner.dart';

class AssignmentDetailsWebInstructorLayout extends StatelessWidget {
  final AssignmentModel assignment;
  final String courseId;

  const AssignmentDetailsWebInstructorLayout({
    super.key,
    required this.assignment,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * 1. Header (Full Width)
            AssignmentDetailsHeader(
              assignment: assignment,
              courseId: courseId,
            ),
            const SizedBox(height: 32),

            // * 2. Adaptive Content (Desktop vs Tablet)
            width > 990
                ? _buildDesktopContent(context)
                : _buildTabletContent(context),
          ],
        ),
      ),
    );
  }

  // * Desktop Layout (Two Columns: Main Info | Sidebar Actions)
  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Schedule & Status Banner
        Expanded(
          flex: 6,
          child: _buildMainBody(context),
        ),
        const SizedBox(width: 40),
        // Right Column: Action List Container
        Expanded(
          flex: 4,
          child: _buildSideContent(),
        ),
      ],
    );
  }

  // * Tablet Layout (Single Column)
  Widget _buildTabletContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainBody(context),
        const SizedBox(height: 32),
        _buildSideContent(),
      ],
    );
  }

  // * Main Body Content (Schedule Card & Status Banner)
  Widget _buildMainBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssignmentDetailsScheduleCard(assignment: assignment),
        const SizedBox(height: 32),

        // AssignmentContextualBanner(assignment: assignment),
        AssignmentStatsRow(assignment: assignment),

        const SizedBox(height: 32),
        AssignmentContentGrid(assignment: assignment),
        const SizedBox(height: 32),
        _buildPremiumUploadZone(context),
        const SizedBox(height: 32),
      ],
    );
  }

  // * Sidebar Container for Instructor Actions
  Widget _buildSideContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.primaryLightActive),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AssignmentActionsList(
            assignment: assignment,
            courseId: courseId,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        AssignmentInstructorBanner(
          assignment: assignment,
        ),
      ],
    );
  }

  // bool _isDraft() {
  //   return assignment.status == AssignmentStatus.assigned &&
  //       assignment.points == 0;
  // }

  Widget _buildPremiumUploadZone(BuildContext context) {
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
                    'Click to upload new assignment',
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
