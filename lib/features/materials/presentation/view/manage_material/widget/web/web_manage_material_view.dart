import 'package:flutter/material.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/web/web_manage_material_view_body.dart';

class WebManageMaterialView extends StatelessWidget {
  const WebManageMaterialView({super.key,required this.isEditMode});

  final bool isEditMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebManageMaterialViewBody(isEditMode: isEditMode,),
    );
  }
}
