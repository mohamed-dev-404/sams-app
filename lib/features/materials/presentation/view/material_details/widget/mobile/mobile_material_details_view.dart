import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/mobile/mobile_custom_app_bar.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/mobile/mobile_material_details_view_body.dart';

class MobileMaterialDetailsView extends StatelessWidget {
  const MobileMaterialDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MobileCustomAppBar(title: 'Material Details'),
      body: MobileMaterialDetailsViewBody(),
    );
  }
}
