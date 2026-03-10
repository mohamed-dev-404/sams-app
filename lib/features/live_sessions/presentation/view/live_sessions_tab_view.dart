import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/live_sessions/presentation/view/widget/live_sessions_mobile_layout.dart';
import 'package:sams_app/features/live_sessions/presentation/view/widget/live_sessions_web_layout.dart';

class LiveSessionsTabView extends StatelessWidget {
  final String courseId;
  const LiveSessionsTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const LiveSessionsMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const LiveSessionsWebLayout();
      },
    );
  }
}
