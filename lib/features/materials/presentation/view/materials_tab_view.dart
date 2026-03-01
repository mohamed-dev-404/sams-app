import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/materials_mobile_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/materials_web_layout.dart';

class MaterialsTabView extends StatelessWidget {
  final String courseId;
  const MaterialsTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MaterialsMobileLayout(),
      webLayout: (context) => const MaterialsWebLayout(),
    );
  }
}
