import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/mobile/mobile_home_view.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/web/web_home_view.dart';

//* The main home screen for both instructors and students
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MobileHomeView(),
      webLayout: (context) => const WebHomeView(),
    );
  }
}
