import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/mobile/mobile_custom_app_bar.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/mobile/mobile_manage_material_view_body.dart';

class MobileManageMaterialView extends StatelessWidget {
  const MobileManageMaterialView({super.key, required this.isEditMode});
   final bool isEditMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MobileCustomAppBar(
        title: isEditMode ? 'Edit Material' : 'Add Material',
      ),
      body: MobileManageMaterialViewBody(
        isEditMode: isEditMode,
      ),
    );
  }
}
