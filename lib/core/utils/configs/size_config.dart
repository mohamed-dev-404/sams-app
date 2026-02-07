import 'package:flutter/material.dart';

class SizeConfig {
  SizeConfig._();

  // Breakpoint
  static const double mobileBreakpoint = 500;

  // base design sizes
  static const Size mobileBaseSize = Size(375, 812);
  static const Size webBaseSize = Size(1440, 1024);

  // layout Check if device is mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= mobileBreakpoint;

  // Get appropriate design size for using in ScreenUtil initialization
  static Size getDesignSize(BuildContext context) {
    return isMobile(context) ? mobileBaseSize : webBaseSize;
  }

  // Screen dimensions helpers
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
