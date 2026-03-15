import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/core/widgets/shared/app_grid_style.dart';
import 'package:sams_app/core/widgets/shared/tab_body_view.dart';
import 'package:sams_app/core/widgets/web/web_main_card.dart';
import 'package:sams_app/features/materials/presentation/view/material_details_view.dart';

//! Materials_web_layout.dart
class MaterialsWebLayout extends StatelessWidget {
  const MaterialsWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final materials = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    final bool isInstructor = CurrentRole.role == UserRole.instructor;
    final bool isMobile = SizeConfig.isMobile(context);
    return TabBodyView(
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (isInstructor && index == materials.length) {
                  //&& index == state.aterials.length
                  return AddNewCard(
                    isMobile: isMobile,
                    title: 'Add Material',
                    onTap: () {},
                  );
                }

                return WebMainCard(
                  model: MainCardModel(
                    title: 'Materials Lec $index',
                    description: 'Materials Description',
                    image: AppImages.imagesMaterialCard,
                    onTap: () {
                      //! navigate to material details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MaterialDetailsView(),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: materials.length + (isInstructor ? 1 : 0),
            ),
            gridDelegate: AppGridStyles.tapGridDelegate,
          ),
        ],
      ),
    );
  }
}
