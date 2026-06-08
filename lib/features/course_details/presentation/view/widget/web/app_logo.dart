import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/assets/app_branding.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(RoutesName.courses),
      child: Image.asset(
        AppBranding.logoWithoutSloganWhiteVersion,
        height: 80,
      ),
    );
  }
}
