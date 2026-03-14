import 'package:flutter/material.dart';

class AppGridStyles {
  static const tapGridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 300,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    mainAxisExtent: 200,
  );
}
