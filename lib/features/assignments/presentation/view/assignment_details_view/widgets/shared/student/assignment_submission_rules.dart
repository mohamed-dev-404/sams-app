import 'package:flutter/material.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/shared/student/app_instructions_section.dart';

class AssignmentSubmissionRules extends StatelessWidget {
  const AssignmentSubmissionRules({super.key});

  @override
  Widget build(BuildContext context) {
    return const AssignmentInstructionsSection(
      title: 'Submission Rules',
      instructions: [
        'Supported formats: .pdf, .zip, .png, .jpg',
        'Maximum file size per upload: 25MB',
        'You can resubmit multiple times before the deadline.',
        'Late submissions will be automatically marked as "Late".',
      ],
    );
  }
}
