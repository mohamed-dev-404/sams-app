import 'package:flutter/widgets.dart';

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

/// Usage:
/// hideKeyboard(context);
