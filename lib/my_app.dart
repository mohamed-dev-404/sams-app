import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/router/app_router.dart';
import 'package:sams_app/core/utils/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Set default design size based on initial screen width before context is available
      designSize: _getInitialDesignSize(),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'SAMS App',
          routerConfig: AppRouter.appRouter,
          theme: AppTheme.getAppTheme(),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,

          // DevicePreview configuration
          locale: DevicePreview.locale(context),

          // This builder wraps EVERY screen in the app
          builder: (context, widget) {
            // 1. Wrap with DevicePreview builder first
            widget = DevicePreview.appBuilder(context, widget);

            // 2. Update responsive sizing when layout changes
            // Important for web when user resizes the browser window
            ScreenUtil.init(
              context,
              designSize: SizeConfig.getDesignSize(context),
            );

            // 3. Get system MediaQuery data (includes user's font size settings)
            final systemData = MediaQuery.of(context);

            // 4. Create modified data - lock text scaling to maintain design consistency
            // This forces all text to ignore the system font size settings
            final modifiedData = systemData.copyWith(
              textScaler: const TextScaler.linear(1.0),
            );

            // 5. Provide modified data to all screens
            return MediaQuery(
              data: modifiedData,
              child: SafeArea(
                top: false,
                bottom: true,
                child: widget,
              ), // <- Your actual screens go here (all routes)
            );
          },
        );
      },
    );
  }

  /// Get initial design size before we have context
  /// Checks actual screen width to determine if mobile or web layout
  Size _getInitialDesignSize() {
    // Access the physical window directly
    final window = WidgetsBinding.instance.platformDispatcher.views.first;

    // Calculate logical width (physical pixels ÷ pixel density)
    // Its considered width in pixels
    final width = window.physicalSize.width / window.devicePixelRatio;

    // Return appropriate design size based on screen width
    return width <= SizeConfig.mobileBreakpoint
        ? SizeConfig.mobileBaseSize
        : SizeConfig.webBaseSize;
  }
}
