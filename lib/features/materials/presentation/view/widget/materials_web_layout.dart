import 'package:flutter/material.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/widgets/web_main_card.dart';

//! Materials_web_layout.dart
class MaterialsWebLayout extends StatelessWidget {
  const MaterialsWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        WebMainCard(
          model: MainCardModel(
            title: 'Chapter 1',
            description: 'Chapter 1: Database Fundamentals and theories',
            image: AppImages.imagesMaterialCard,
            onTap: () {},
          ),
        ),
        WebMainCard(
          model: MainCardModel(
            title: 'Chapter 1',
            description: 'Chapter 1: Database Fundamentals and theories',
            image: AppImages.imagesMaterialCard,
            onTap: () {},
          ),
        ),
        WebMainCard(
          model: MainCardModel(
            title: 'Chapter 1',
            description: 'Chapter 1: Database Fundamentals and theories',
            image: AppImages.imagesMaterialCard,
            onTap: () {},
          ),
        ),
        WebMainCard(
          model: MainCardModel(
            title: 'Chapter 1',
            description: 'Chapter 1: Database Fundamentals and theories',
            image: AppImages.imagesMaterialCard,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
