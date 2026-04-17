import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/mobile/mobile_material_details_view.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/web/web_material_details_view.dart';

/// A wrapper widget that manages the Material Details screen across different platforms.
/// It extracts routing parameters and delegates the UI to platform-specific layouts.
class MaterialDetailsView extends StatelessWidget {
  const MaterialDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    //* Logic: Extract the [courseId] from the current routing state.
    //? We do this at the top level to ensure both Mobile and Web views receive the same ID.
    final String courseId =
        GoRouterState.of(context).pathParameters['courseId'] ?? '';

    return AdaptiveLayout(
      //* Mobile/Tablet Layout: Displays a scrollable sliver-based view.
      mobileLayout: (context) => MobileMaterialDetailsView(
        courseId: courseId,
      ),

      //* Web/Desktop Layout: Displays a dual-pane dashboard-style view.
      webLayout: (context) => WebMaterialDetailsView(
        courseId: courseId,
      ),
    );
  }
}
