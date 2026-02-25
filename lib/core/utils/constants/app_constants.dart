import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  AppConstants._();

  //? Base URL
  static String get baseUrl {
    if (kIsWeb) {
      // For Web, localhost is usually fine
      return 'http://localhost:3000/api/v1/';
    } else if (Platform.isAndroid) {
      // Android Emulator needs the 10.0.2.2 alias
      return 'http://10.0.2.2:3000/api/v1/';
    } else {
      // iOS Simulator or macOS/Windows desktop
      return 'http://localhost:3000/api/v1/';
    }
  }

  // static String baseUrl = 'http://localhost:3000/api/v1/';
  // static const String kToken = 'token';
  // static const String isLoggedIn = 'isLoggedIn';
  // static const kNavigationTransition = Duration(milliseconds: 1000);
  // static const String kDateFormat = 'yyyy-MM-dd';
  // ... other constants
}
