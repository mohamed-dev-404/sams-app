import 'package:flutter/material.dart';

import '../shared/material_item_card.dart';

class MaterialsSliverList extends StatelessWidget {
  MaterialsSliverList({super.key});

  final List<Map<String, dynamic>> materials = [
    {
      'name': 'Lecture 1.pdf',
      'desc': 'Introduction to Relational DB',
      'type': CourseMaterialType.pdf,
    },
    {
      'name': 'Intro Video.mp4',
      'desc': 'Overview of the course',
      'type': CourseMaterialType.video,
    },
    {
      'name': 'Assignment 1.pdf',
      'desc': 'Database Schema Design',
      'type': CourseMaterialType.pdf,
    },
    {
      'name': 'Intro Video.mp4',
      'desc': 'Overview of the course',
      'type': CourseMaterialType.video,
    },
    {
      'name': 'Intro Video.mp4',
      'desc': 'Overview of the course',
      'type': CourseMaterialType.video,
    },
    {
      'name': 'Lecture 1.pdf',
      'desc': 'Introduction to Relational DB',
      'type': CourseMaterialType.pdf,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return MaterialItemCard(
            fileName: materials[index]['name']!,
            description: materials[index]['desc']!,
            materialType: materials[index]['type']!,
          );
        },
        childCount: materials.length,
      ),
    );
  }
}