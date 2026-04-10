import 'package:flutter/material.dart';
import 'package:sams_app/features/announcements/presentation/view/add_announcement/widget/mobile/add_announcement_mobile_view_body.dart';

class AddAnnouncementMobileView extends StatelessWidget {
  const AddAnnouncementMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AddAnnouncementMobileViewBody()),
    );
  }
}
