import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/mobile/mobile_main_card.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubit/material_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubit/material_state.dart';
import 'package:sams_app/features/materials/presentation/view/material_details_view.dart';

//* Displays the 'Materials' section for mobile
class MaterialsMobileLayout extends StatelessWidget {
  const MaterialsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialCubit, MaterialsState>(
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
                      //! navigate to add material
                    },
                  ),
                ),
              ),

            //? 2. Handling Loading State
            if (state is MaterialLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: AppAnimatedLoadingIndicator()),
              ),

            //? 3. Handling Failure State (When no cache is available)
            if (state is MaterialFailure)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text(state.errMessage)),
              ),

            //? 4. Handling Success State (Displaying the List)
            if (state is MaterialSuccess)
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
                            //! navigate to material details
                            // context.read<MaterialsCubit>().fetchMaterialDetails(materialId: material.id);
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
