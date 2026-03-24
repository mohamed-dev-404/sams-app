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
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/mobile/material_sliver_list.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

class MobileMaterialDetailsViewBody extends StatelessWidget {
  const MobileMaterialDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
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
            slivers: [
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
                          if (CurrentRole.role == UserRole.instructor)
                             Padding(
                               padding: const EdgeInsets.only(left: 10),
                               child: IconButton (
                                onPressed: () async {
                                  // 1. Get courseId from the current route parameters
                                  final courseId =
                                      GoRouterState.of(
                                        context,
                                      ).pathParameters['courseId'] ??
                                      '';
                               
                                  // 2. Push to manageMaterial and pass the current material model as 'extra'
                                  final updatedMaterial = await context.pushNamed(
                                    RoutesName.manageMaterial,
                                    pathParameters: {
                                      'courseId': courseId,
                                    },
                                    extra:
                                        material, 
                                  );
                               
                                  // 3. Update the UI if the user edited and saved
                                  if (updatedMaterial is MaterialModel &&
                                      context.mounted) {
                                    // Here you should call a method to refresh the current details view
                                    context
                                        .read<MaterialFetchCubit>()
                                        .updateMaterialDetails(updatedMaterial);
                                    AppSnackBar.success(
                                      context,
                                      'Changes saved!',
                                    );
                                  }
                                },
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
              MaterialsSliverList(materials: material.materialItems),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
