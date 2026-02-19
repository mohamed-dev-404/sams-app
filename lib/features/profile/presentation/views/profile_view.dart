import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/profile/presentation/views/layouts/mobile_profile_view.dart';
import 'package:sams_app/features/profile/presentation/views/layouts/web_profile_view.dart';

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
