import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

import 'package:sams_app/features/materials/presentation/view/widget/shared/mobile_manage_material_view_body.dart';

class MobileManageMaterialView extends StatelessWidget {
  final bool isEditing;

  const MobileManageMaterialView({super.key,required this.isEditing });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Material' : 'Add Material'),
        leading: const Icon(
          Icons.arrow_circle_left_outlined,
          color: AppColors.primaryDarkHover,
          size: 38,
        ),
      ),
      body: MobileManageMaterialViewBody(
        isEditing: isEditing,
      ),
    );
  }
}
