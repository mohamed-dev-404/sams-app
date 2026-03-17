import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/mobile/mobile_materials_details_view.dart';
import 'package:sams_app/features/materials/presentation/view/widget/web/web_material_details_view.dart';

class MaterialDetailsView extends StatelessWidget {
  const MaterialDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MobileMaterialsDetailsView(),
      webLayout: (context) => const WebMaterialDetailsView(),
    );
  }
}