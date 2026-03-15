import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material_view.dart';
import 'package:sams_app/features/materials/presentation/view/widget/mobile/mobile_manage_material_view.dart';
import 'package:sams_app/features/materials/presentation/view/widget/shared/mobile_materials_details_view_body.dart';

class MobileMaterialsDetailsView extends StatelessWidget {
  const MobileMaterialsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ManageMaterialView(isEditing: false)));
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      appBar: AppBar(
        title: const Text('Material Details'),
        leading: const Icon(
          Icons.arrow_circle_left_outlined,
          color: AppColors.primaryDarkHover,
          size: 38,
        ),
      ),
      body: const MobileMaterialsDetailsViewBody(),
    );
  }
}
