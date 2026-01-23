import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/app_initializer.dart';
import 'package:sams_app/my_app.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize app services
  await AppInitializer.init();

  runApp(
    DevicePreview(
      enabled: kReleaseMode ? false : true,
      builder: (context) => const MyApp(),
    ),
  );
}
