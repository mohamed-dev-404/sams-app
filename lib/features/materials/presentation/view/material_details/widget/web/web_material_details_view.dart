import 'package:flutter/material.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/add_material_items_floating_buttom.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/web/web_material_details_view_body.dart';

class WebMaterialDetailsView extends StatelessWidget {
  final String courseId;

  const WebMaterialDetailsView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddMaterialItemsFloatingBuutton(courseId: courseId),
      body: const WebMaterialDetailsViewBody(),
    );
  }
}
