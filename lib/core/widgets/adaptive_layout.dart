import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    required this.webLayout,
  });

  final WidgetBuilder mobileLayout;
  final WidgetBuilder webLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= SizeConfig.mobileBreakpoint) {
          return mobileLayout(context);
        } else {
          return webLayout(context);
        }
      },
    );
  }
}
