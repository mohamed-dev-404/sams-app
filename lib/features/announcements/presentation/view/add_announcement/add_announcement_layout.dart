import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/announcements/presentation/view/add_announcement/widget/mobile/add_announcement_mobile_view.dart';

class AddAnnouncementLayout extends StatelessWidget {
  const AddAnnouncementLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const AddAnnouncementMobileView(),
      webLayout: (context) =>  const SizedBox.shrink(),
    );
  }
}
