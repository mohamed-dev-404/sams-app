import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/widgets/mobile/mobile_main_card.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';

//* Displays the 'Materials' section for mobile
class MaterialsMobileLayout extends StatelessWidget {
  const MaterialsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //? Displays the role-based instructor 'AddNewMaterialCard'
        if (CurrentRole.role == UserRole.instructor)
           SliverPadding(
            padding:const EdgeInsets.symmetric(vertical: 7),
            sliver: SliverToBoxAdapter(
              child: AddNewCard(isMobile: true, title: 'Add Material', onTap: () {  },),
            ),
          ),

        //? Displays the 'Materials' section
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: MobileMainCard(
                cardModel: MainCardModel(
                  title: 'Materials Lec $index',
                  description: 'Materials Description',
                  image: AppImages.imagesMaterialCard,
                  onTap: () => {},
                ),
              ),
            ),
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
