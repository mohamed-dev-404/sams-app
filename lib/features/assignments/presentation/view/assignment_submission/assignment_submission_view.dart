import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_submission/mobile/assignment_submission_mobile_layout.dart';

class AssignmentSubmissionView extends StatelessWidget {
  const AssignmentSubmissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return  AdaptiveLayout(
      mobileLayout: ( context) => const AssignmentSubmissionMobileLayout(),
     webLayout: (context) => const Placeholder(),);
  }
}