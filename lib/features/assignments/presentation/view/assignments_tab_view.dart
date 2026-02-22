import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/widget/assignments_mobile_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/widget/assignments_web_layout.dart';

class AssignmentsTabView extends StatelessWidget {
  const AssignmentsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const AssignmentsMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const AssignmentsWebLayout();
      },
    );
  }
}
