import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/materials_mobile_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/materials_web_layout.dart';

class MaterialsTabView extends StatelessWidget {
  const MaterialsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const MaterialsMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const MaterialsWebLayout();
      },
    );
  }
}
