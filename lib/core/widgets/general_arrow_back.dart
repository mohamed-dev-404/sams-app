//todo shared custom arrow back widget used in the app
import 'package:flutter/material.dart';

class GeneralArrowBack extends StatelessWidget {
  const GeneralArrowBack({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: color),
      ),
      child: Icon(
        size: 20,
        Icons.arrow_back_rounded,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
