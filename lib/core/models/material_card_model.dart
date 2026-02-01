import 'package:flutter/foundation.dart';

class MaterialCardModel {
  final String title;
  final String description;
  final String image;
  final VoidCallback onTap;

  MaterialCardModel({
    required this.title,
    required this.description,
    required this.image,
    required this.onTap
  });
}