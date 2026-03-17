import 'package:flutter/material.dart';
import 'package:sams_app/features/materials/presentation/view/widget/shared/material_item_card.dart';

class MaterialContentGrid extends StatelessWidget {
  const MaterialContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display two items per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 220 / 70, // Adjusts the height relative to width
      ),
      itemCount: 10, // Replace with actual data length
      itemBuilder: (context, index) {
        return const MaterialItemCard(
          fileName: 'Lecture Five',
          description: 'Introduction to Relational DB and basic query structures.',
          materialType: CourseMaterialType.video,
        );
      },
    );
  }
}