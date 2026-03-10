import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/announcements/presentation/view/widget/announcements_mobile_layout.dart';
import 'package:sams_app/features/announcements/presentation/view/widget/announcements_web_layout.dart';

class AnnouncementsTabView extends StatelessWidget {
  final String courseId;
  const AnnouncementsTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const AnnouncementsMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const AnnouncementsWebLayout();
      },
    );
  }
}
