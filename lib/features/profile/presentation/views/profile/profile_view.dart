import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/profile/presentation/views/profile/widgets/mobile/mobile_profile_view.dart';
import 'package:sams_app/features/profile/presentation/views/profile/widgets/web/web_profile_view.dart';

//* The main profile screen for both instructors and students
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MobileProfileView(),
      webLayout: (context) => const WebProfileView(),
    );
  }
}
