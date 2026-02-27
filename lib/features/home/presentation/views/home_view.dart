import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/home/presentation/views/layouts/mobile_home_view.dart';
import 'package:sams_app/features/home/presentation/views/layouts/web_home_view.dart';

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
