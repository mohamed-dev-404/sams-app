import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/mobile/mobile_material_details_view.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';

class MaterialDetailsView extends StatelessWidget {
  const MaterialDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final materialId =
        GoRouterState.of(context).pathParameters['materialId'] ?? '';
    return BlocProvider(
      create: (context) =>
          getIt<MaterialFetchCubit>()
            ..fetchMaterialDetails(materialId: materialId),
      child: AdaptiveLayout(
        mobileLayout: (context) => const MobileMaterialDetailsView(),
        webLayout: (context) => const Placeholder(),
      ),
    );
  }
}
