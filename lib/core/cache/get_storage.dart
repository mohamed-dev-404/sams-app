// ignore_for_file: unintended_html_in_doc_comment

import 'package:get_storage/get_storage.dart';

/// GetStoragePrefs
/// -------------------------------
/// A simple wrapper around GetStorage to easily save & read local data.
/// Use it for things like theme, language, or small user preferences.
///
/// IMPORTANT: Before using, call this in `main()`:
///   WidgetsFlutterBinding.ensureInitialized();
///   await GetStorage.init();

class GetStorageHelper {
  //  Shared storage box (like a small key-value database)
  static final GetStorage _box = GetStorage();

  //! ===============================
  //!  Generic Methods
  //! ===============================

  ///* Save data by key.
  /// Example:
  ///   await GetStoragePrefs.write('username', 'Karem');
  static Future<void> write(String key, dynamic value) async =>
      await _box.write(key, value);

  ///* Read data by key. Returns `null` if not found.
  /// Example:
  ///   final name = GetStoragePrefs.read<String>('username');
  ///   print(name); // Karem
  static T? read<T>(String key) => _box.read<T>(key);

  ///* Check if a key exists.
  /// Example:
  ///   if (GetStoragePrefs.hasKey('username')) print('User found');
  static bool hasKey(String key) => _box.hasData(key);

  ///* Remove a single key.
  /// Example:
  ///   await GetStoragePrefs.remove('username');
  static Future<void> remove(String key) async => await _box.remove(key);

  ///* Clear all data.
  /// Example:
  ///   await GetStoragePrefs.erase();
  static Future<void> erase() async => await _box.erase();

  //! ===============================
  //!  Shortcut Methods
  //! ===============================

  ///* Save theme mode ("light", "dark", "system")
  /// Example:
  ///   await GetStoragePrefs.setThemeMode('light');
  static Future<void> setThemeMode(String value) async =>
      await write('theme_mode', value);

  ///* Get theme mode
  /// Example:
  ///   final theme = GetStoragePrefs.getThemeMode(); // light
  static String? getThemeMode() => read<String>('theme_mode');

  ///* Save app language ("en", "ar")
  /// Example:
  ///   await GetStoragePrefs.setLanguage('ar');
  static Future<void> setLanguage(String lang) async =>
      await write('app_lang', lang);

  ///* Get app language
  /// Example:
  ///   final lang = GetStoragePrefs.getLanguage(); // ar
  static String? getLanguage() => read<String>('app_lang');

  //* Save onboarding status
  static Future<void> setOnboardingSeen(bool value) async {
    await _box.write('hasSeenOnBoarding', value);
  }

  //* Delete onboarding status
  static Future<void> deleteOnboardingSeen() async {
    await _box.remove('hasSeenOnBoarding');
  }

  //* Check if onboarding was seen
  static bool hasSeenOnBoarding() {
    return _box.read('hasSeenOnBoarding') ?? false;
  }
}
