import 'package:flutter/material.dart';

abstract class MaterialRefreshTrigger {
  static final ValueNotifier<bool> shouldRefresh = ValueNotifier(false);

  static void requestRefresh() {
    shouldRefresh.value = !shouldRefresh.value;
  }
}