import 'package:flutter/material.dart';

class TabBodyView extends StatelessWidget {
  const TabBodyView({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(40, 0, 40, 40),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}
