import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
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
                        children: [
                          Text(
                            material.title.split(' ').first,
                            style: AppStyles.mobileTitleLargeMd.copyWith(
                              color: AppColors.primaryDarkHover,
                            ),
                          ),
                          if (CurrentRole.role == UserRole.instructor)
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  RoutesName.manageMaterial,
                                  extra: material,
                                );
                              },
                              child: SvgPicture.asset(
                                AppIcons.iconsEditMaterial,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        material.title,
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
