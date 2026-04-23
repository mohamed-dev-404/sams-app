import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_attached_files_grid.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_details_header.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/common/assignment_stats_row.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/student/app_instructions_section.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/student/assignment_student_action_card.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/student/work_submission_card.dart';

class AssignmentDetailsWebStudentLayout extends StatefulWidget {
  final AssignmentModel assignment;
  final String courseId;

  const AssignmentDetailsWebStudentLayout({
    super.key,
    required this.assignment,
    required this.courseId,
  });

  @override
  State<AssignmentDetailsWebStudentLayout> createState() =>
      _AssignmentDetailsWebStudentLayoutState();
}

class _AssignmentDetailsWebStudentLayoutState
    extends State<AssignmentDetailsWebStudentLayout> {
  List<PlatformFile> myPickedFiles = [];
  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: width > 940
            ? _buildDesktopLayout(context)
            : _buildTabletLayout(context),
      ),
    );
  }

  // * 1. Desktop Layout (Two Columns)
  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssignmentDetailsHeader(
          assignment: widget.assignment,
          courseId: widget.courseId,
        ),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Left Column: Stats & Instructions (Main Content)
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AssignmentStatsRow(assignment: widget.assignment),
                  const SizedBox(height: 32),
                  AssignmentContentGrid(assignment: widget.assignment),
                  const SizedBox(height: 32),
                  _buildInstructions(),
                ],
              ),
            ),
            const SizedBox(width: 40),
            //* Right Column: Dynamic Action Area (Sidebar)
            Expanded(
              flex: 4,
              child: _buildSideContent(context),
            ),
          ],
        ),
      ],
    );
  }

  // * 2. Tablet Layout (Single Column Stacked)
  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssignmentDetailsHeader(
          assignment: widget.assignment,
          courseId: widget.courseId,
        ),
        const SizedBox(height: 32),
        AssignmentStatsRow(assignment: widget.assignment),
        const SizedBox(height: 32),
        _buildSideContent(context),
        const SizedBox(height: 32),
        _buildInstructions(),
      ],
    );
  }

  // * 3. Instructions & Guidelines Section
  Widget _buildInstructions() {
    if (widget.assignment.status == AssignmentStatus.missed) {
      return const SizedBox.shrink();
    }

    return const AssignmentInstructionsSection(
      title: 'Submission Instructions',
      instructions: [
        'Accepted formats: PDF, DOCX, or ZIP for multiple files.',
        'Maximum file size allowed is 50MB.',
        'Ensure your work is original to pass the plagiarism check.',
        'You can resubmit anytime before the deadline.',
      ],
    );
  }

  // * 4. Side Content (Deadline Timer & Submit Actions)
  Widget _buildSideContent(BuildContext context) {
    final bool isExpired = widget.assignment.dueDate.isBefore(DateTime.now());
    final bool isSubmitted =
        widget.assignment.status == AssignmentStatus.handedIn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isExpired && !isSubmitted) ...[
          // DeadlineTimer(endTime: assignment.dueDate),
          const SizedBox(height: 24),
        ],

        AssignmentStudentActionCard(
          assignment: widget.assignment,
          onUploadPressed: () {
            _showWorkSubmissionDialog(widget.assignment, myPickedFiles);
          },
        ),
      ],
    );
  }

  void _showWorkSubmissionDialog(
    AssignmentModel assignment,
    List<PlatformFile> myPickedFiles,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: 500,
                child: WorkSubmissionCard(
                  status: assignment.status,
                  pickedFiles: myPickedFiles,
                  onFilesPicked: (newFiles) {
                    setState(() => myPickedFiles.addAll(newFiles));
                    setDialogState(() {});
                  },

                  onRemoveFile: (index) {
                    setState(() => myPickedFiles.removeAt(index));
                    setDialogState(() {});
                  },

                  onActionPressed: () {},
                ),
              ),
            );
          },
        );
      },
    );
  }
}
