import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/mobile/mobile_main_card.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

//* Displays the 'Materials' section for mobile
class MaterialsMobileLayout extends StatelessWidget {
  const MaterialsMobileLayout({super.key, required this.courseId});

  final String courseId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
      buildWhen: (previous, current) =>
          current is MaterialFetchSuccess ||
          current is MaterialFetchLoading ||
          current is MaterialFetchFailure,
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            //? 1. Instructor "Add" Section (Always on top if role is instructor)
            if (CurrentRole.role == UserRole.instructor)
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                sliver: SliverToBoxAdapter(
                  child: AddNewCard(
                    isMobile: true,
                    title: 'Add Material',
                    onTap: () {
                      context.pushNamed(
                        RoutesName.manageMaterial,
                        pathParameters: {
                          'courseId': courseId,
                        },
                      );
                    },
                  ),
                ),
              ),

            //? 2. Handling Loading State
            if (state is MaterialFetchLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: AppAnimatedLoadingIndicator()),
              ),

            //? 3. Handling Failure State (When no cache is available)
            if (state is MaterialFetchFailure)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text(state.errMessage)),
              ),

            //? 4. Handling Success State (Displaying the List)
            if (state is MaterialFetchSuccess)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final material = state.materials[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: MobileMainCard(
                        cardModel: MainCardModel(
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
                      ),
                    );
                  },
                  childCount: state.materials.length,
                ),
              ),
          ],
        );
      },
    );
  }
}
