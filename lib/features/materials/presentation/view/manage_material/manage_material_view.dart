import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/mobile/mobile_manage_material_view.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/web/web_manage_material_view.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';

class ManageMaterialView extends StatelessWidget {
  const ManageMaterialView({super.key, required this.courseId});
  final String courseId;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MaterialCrudCubit>();
    final bool isEditMode = cubit.initialMaterial != null;
    return AdaptiveLayout(
      mobileLayout: (context) => MobileManageMaterialView(
        isEditMode: isEditMode,
        courseId: courseId,
      ),
      webLayout: (context) => WebManageMaterialView(
        isEditMode: isEditMode, courseId: courseId,
      ),
    );
  }
}
