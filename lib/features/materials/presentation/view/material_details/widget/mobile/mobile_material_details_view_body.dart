import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/logic/material_navigation_handler.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/mobile/material_sliver_list.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

/// The primary body widget for material details on mobile devices.
/// It coordinates state synchronization between [MaterialCrudCubit] and [MaterialFetchCubit]
/// to ensure the UI remains updated after deletions or edits.
class MobileMaterialDetailsViewBody extends StatelessWidget {
  const MobileMaterialDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        //* Listener 1: Syncing Deletion with Fetching.
        //* When an item is deleted successfully, we trigger a refresh of the details.
        BlocListener<MaterialCrudCubit, MaterialCrudState>(
          listener: (context, state) {
            if (state is DeleteMaterialItemSuccess) {
              final fetchCubit = context.read<MaterialFetchCubit>();
              if (fetchCubit.state is MaterialFetchDetailsSuccess) {
                final materialId =
                    (fetchCubit.state as MaterialFetchDetailsSuccess)
                        .material
                        .id;
                fetchCubit.fetchMaterialDetails(materialId: materialId);
              }
            }
          },
        ),
        //* Listener 2: Global UI Feedback.
        //* Once the data is refreshed after a deletion, we close the dialog and notify the user.
        BlocListener<MaterialFetchCubit, MaterialFetchState>(
          listener: (context, state) {
            final crudState = context.read<MaterialCrudCubit>().state;
            //? Logical check to ensure SnackBar only shows after a successful CRUD-triggered refresh.
            if (state is MaterialFetchDetailsSuccess &&
                crudState is DeleteMaterialItemSuccess) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context); // Closes deletion dialog
                AppSnackBar.success(
                  context,
                  'Item deleted and updated successfully!',
                );
              }
            }
          },
        ),
      ],
      child: BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
        //_ Optimized rebuilds: Only listen to states relevant to the details view.
        buildWhen: (previous, current) => current is MaterialDetailsState,
        builder: (context, state) {
          if (state is MaterialFetchLoading) {
            return const Center(child: AppAnimatedLoadingIndicator());
          }

          if (state is MaterialFetchFailure) {
            return Center(child: Text(state.errMessage));
          }

          if (state is MaterialFetchDetailsSuccess) {
            final material = state.material;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                //* Material Info Header Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 22,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 21,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                material.title,
                                style: AppStyles.mobileTitleLargeMd.copyWith(
                                  color: AppColors.primaryDarkHover,
                                ),
                              ),
                            ),
                            //? Role-Based Access: Only instructors can edit material metadata.
                            if (CurrentRole.role == UserRole.instructor)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: IconButton(
                                  onPressed: () =>
                                      _onEditPressed(context, material),
                                  icon: SvgPicture.asset(
                                    AppIcons.iconsEditMaterial,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          material.description,
                          style: AppStyles.mobileBodyMediumRg.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //* Section Divider Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Text(
                      'Material Content',
                      style: AppStyles.mobileTitleMediumSb.copyWith(
                        color: AppColors.primaryDarkHover,
                      ),
                    ),
                  ),
                ),
                //_ Specialized sliver for rendering the list of files (Videos/Docs).
                MaterialsSliverList(
                  materials: material.materialItems,
                  materialId: material.id,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// Extracts navigation parameters and redirects to the edit screen.
  void _onEditPressed(BuildContext context, MaterialModel material) async {
    final courseId = GoRouterState.of(context).pathParameters['courseId'] ?? '';

    //* Navigation Logic: Delegated to the handler for clean architecture.
    MaterialsNavigationHandler.navigateToEditMaterial(
      context,
      courseId: courseId,
      material: material,
    );
  }
}
