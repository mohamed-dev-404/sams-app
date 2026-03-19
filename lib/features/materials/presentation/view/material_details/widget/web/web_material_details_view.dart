import 'package:flutter/material.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/manage_material_view.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/web/web_material_details_view_body.dart';

class WebMaterialDetailsView extends StatelessWidget {
  const WebMaterialDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageMaterialView(courseId: '',),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: MediaQuery.sizeOf(context).width * 0.03,
        ),
      ),
      body: const WebMaterialDetailsViewBody(),
    );
  }
}
