import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/material_tab_view/widget/mobile/materials_mobile_layout.dart';
import 'package:sams_app/features/materials/presentation/view/material_tab_view/widget/web/materials_web_layout.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';

//* Displays the 'Materials' section
class MaterialsTabView extends StatelessWidget {
  final String courseId;
  const MaterialsTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<MaterialFetchCubit>()..fetchMaterials(courseId: courseId),
        ),
        BlocProvider(
          create: (context) => getIt<MaterialCrudCubit>(),
        ),
      ],
      child: AdaptiveLayout(
        mobileLayout: (context) => MaterialsMobileLayout(
          courseId: courseId,
        ),
        webLayout: (context) => MaterialsWebLayout(
          courseId: courseId,
        ),
      ),
    );
  }
}
