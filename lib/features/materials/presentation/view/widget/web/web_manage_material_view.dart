import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/materials/presentation/view/widget/shared/web_manage_material_view_body.dart';

class WebManageMaterialView extends StatelessWidget {
  final bool isEditing;

  const WebManageMaterialView({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: WebManageMaterialViewBody(isEditing: isEditing),
    );
  }
}
