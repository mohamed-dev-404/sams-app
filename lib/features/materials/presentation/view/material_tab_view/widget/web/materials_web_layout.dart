import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/core/widgets/shared/app_grid_style.dart';
import 'package:sams_app/core/widgets/shared/tab_body_view.dart';
import 'package:sams_app/core/widgets/web/web_main_card.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

//* Displays the 'Materials' section for web
class MaterialsWebLayout extends StatelessWidget {
  const MaterialsWebLayout({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    final bool isInstructor = CurrentRole.role == UserRole.instructor;
    final bool isMobile = SizeConfig.isMobile(context);

    return TabBodyView(
      child: BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
        builder: (context, state) {
          // 1. Loading State
          if (state is MaterialFetchLoading) {
            return const Center(child: AppAnimatedLoadingIndicator());
          }

          // 2. Failure State
          if (state is MaterialFetchFailure) {
            return Center(child: Text(state.errMessage));
          }

          // 3. Success State
          if (state is MaterialFetchSuccess) {
            final materials = state.materials;

            return CustomScrollView(
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Check for Instructor's "Add Material" card at the end of the list
                      if (isInstructor && index == materials.length) {
                        return AddNewCard(
                          isMobile: isMobile,
                          title: 'Add Material',
                          onTap: () async {
                            final newMaterial = await context.pushNamed(
                              RoutesName.manageMaterial,
                              pathParameters: {
                                'courseId': courseId,
                              },
                            );

                            if (newMaterial is MaterialModel &&
                                context.mounted) {
                              context
                                  .read<MaterialFetchCubit>()
                                  .addMaterialToListView(newMaterial);
                            }
                          },
                        );
                      }

                      final material = materials[index];

                      return WebMainCard(
                        model: MainCardModel(
                          title: material.title,
                          description: material.description,
                          image: AppImages.imagesMaterialCard,
                          onTap: () {
                            //? Fetching Material details
                            context
                                .read<MaterialFetchCubit>()
                                .fetchMaterialDetails(materialId: material.id);
                            //? Navigating to Material Details
                            context.pushNamed(
                              RoutesName.materialDetails,
                              pathParameters: {
                                'courseId': courseId,
                                'materialId': material.id,
                              },
                            );
                          },
                        ),
                      );
                    },
                    // Materials count + 1 for the instructor's add button
                    childCount: materials.length + (isInstructor ? 1 : 0),
                  ),
                  gridDelegate: AppGridStyles.tapGridDelegate,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
