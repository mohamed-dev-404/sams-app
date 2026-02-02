import 'package:flutter/foundation.dart';

class MainCardModel {
  final String title;
  final String description;
  final String image;
  final VoidCallback onTap;

  MainCardModel({
    required this.title,
    required this.description,
    required this.image,
    required this.onTap,
  });
}
