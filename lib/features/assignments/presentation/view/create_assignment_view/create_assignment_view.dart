import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/create_assignment_view/widgets/mobile/create_assignment_mobile_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/create_assignment_view/widgets/web/create_assiment_web_layout.dart';

class CreateAssignmentView extends StatelessWidget {
  final String? assignmentId;

  const CreateAssignmentView({super.key, this.assignmentId});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const CreateAssignmentMobileLayout(),
      webLayout: (context) => const CreateAssignmentWebLayout(),
    );
  }
}
