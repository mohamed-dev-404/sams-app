import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/mobile/mobile_custom_app_bar.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/mobile/mobile_material_details_view_body.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/add_material_items_floating_buttom.dart';

class MobileMaterialDetailsView extends StatelessWidget {
  const MobileMaterialDetailsView({super.key, required this.courseId});
  final String courseId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobileCustomAppBar(title: 'Material Details'),
      floatingActionButton: AddMaterialItemsFloatingBuutton(courseId: courseId),
      body: const MobileMaterialDetailsViewBody(),
    );
  }
}
