import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/mobile/materials_mobile_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/web/materials_web_layout.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubit/material_cubit.dart';

//* Displays the 'Materials' section
class MaterialsTabView extends StatelessWidget {
  final String courseId;
  const MaterialsTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MaterialCubit>()..fetchMaterials(courseId: courseId),
      child: AdaptiveLayout(
        mobileLayout: (context) => const MaterialsMobileLayout(),
        webLayout: (context) => const MaterialsWebLayout(),
      ),
    );
  }
}
