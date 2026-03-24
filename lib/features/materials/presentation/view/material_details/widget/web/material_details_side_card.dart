import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

class MaterialDetailsSideCard extends StatelessWidget {
  const MaterialDetailsSideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
      builder: (context, state) {
        if (state is! MaterialFetchDetailsSuccess)
          return const SizedBox.shrink();

        final material = state.material;

        return LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;

            return Container(
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Illustration Image
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/hijab_image.svg',
                        width: width * 0.6,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title and Edit Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            material.title,
                            style: AppStyles.webTitleMediumSb.copyWith(
                              color: AppColors.primaryDarkHover,
                              fontSize: (width * 0.09).clamp(20, 28),
                            ),
                          ),
                        ),
                        // Show edit button only for instructors
                        if (CurrentRole.role == UserRole.instructor)
                          IconButton(
                            onPressed: () => _onEditPressed(context, material),
                            icon: SvgPicture.asset(
                              AppIcons.iconsEditMaterial,
                              width: 24,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description text
                    Text(
                      material.description,
                      style: AppStyles.mobileBodyLargeRg.copyWith(
                        color: AppColors.primary,
                        fontSize: (width * 0.06).clamp(14, 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Handles navigating to the manage material screen for editing
  void _onEditPressed(BuildContext context, MaterialModel material) async {
    final courseId = GoRouterState.of(context).pathParameters['courseId'] ?? '';

    final updatedMaterial = await context.pushNamed(
      RoutesName.manageMaterial,
      pathParameters: {'courseId': courseId},
      extra: material, // Passing existing model to populate the form
    );

    // If the material was updated, refresh the details UI
    if (updatedMaterial is MaterialModel && context.mounted) {
      context.read<MaterialFetchCubit>().updateMaterialDetails(updatedMaterial);
      AppSnackBar.success(context, 'Changes saved!');
    }
  }
}
