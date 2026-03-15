import 'package:flutter/widgets.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/materials/presentation/view/widget/mobile/mobile_manage_material_view.dart';
import 'package:sams_app/features/materials/presentation/view/widget/web/web_manage_material_view.dart';

class ManageMaterialView extends StatelessWidget {
  const ManageMaterialView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MobileManageMaterialView(isEditing: true),
      webLayout: (context) => const WebManageMaterialView(isEditing: true),
    );
  }
}
