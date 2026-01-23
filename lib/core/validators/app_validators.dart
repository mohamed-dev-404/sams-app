import 'package:sams_app/core/functions/is_null_or_empty.dart';
import 'package:sams_app/core/validators/app_regx.dart';

///  Contains all ready-to-use Form Validators for TextFormField
abstract class AppValidators {
  /// Validates a general name (letters only, min 3 characters)
  static String? validateName(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Name is required';
    } else if (!AppRegex.isUserNameValid(value!.trim())) {
      return 'Enter a valid name (letters only, at least 3 characters)';
    }
    return null;
  }

  /// Validates an Arabic name
  static String? validateArabicName(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Name is required';
    } else if (!AppRegex.isArabicNameValid(value!.trim())) {
      return 'Enter a valid Arabic name';
    }
    return null;
  }

  /// Validates an Egyptian phone number
  static String? validatePhone(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Phone number is required';
    } else if (!AppRegex.isValidEgyptianPhoneNumber(value!.trim())) {
      return 'Enter a valid Egyptian phone number';
    }
    return null;
  }

  /// Validates a global phone number
  static String? validateGlobalPhone(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Phone number is required';
    } else if (!AppRegex.isGlobalPhoneNumberValid(value!.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Validates email format
  static String? validateEmail(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Email is required';
    } else if (!AppRegex.isEmailValid(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Validates password (min 8 characters, letters & numbers)
  static String? validatePassword(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Password is required';
    } else if (!AppRegex.isPasswordValid(value!.trim())) {
      return 'Password must be at least 8 characters,\ncontain at least one letter and one number';
    }
    return null;
  }

  /// Validates that confirm password matches the original
  static String? validateConfirmPassword(String? confirm, String original) {
    if (isNullOrEmpty(confirm)) {
      return 'Please confirm your password';
    } else if (confirm != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates a numeric input with optional min/max range
  static String? validateNumber(String? value, {int? min, int? max}) {
    if (isNullOrEmpty(value)) {
      return 'This field is required';
    } else if (!AppRegex.isNumeric(value!)) {
      return 'Only numbers are allowed';
    } else {
      final num number = num.parse(value);
      if (min != null && number < min) return 'Number must be at least $min';
      if (max != null && number > max) return 'Number must be at most $max';
    }
    return null;
  }

  /// Validates that a field is not empty
  static String? validateNotEmpty(
    String? value, [
    String message = 'This field is required',
  ]) {
    if (isNullOrEmpty(value)) {
      return message;
    }
    return null;
  }
}

///  Example usage inside TextFormField
///
/// 
/// TextFormField(
///   decoration: const InputDecoration(labelText: "Email"),
///   validator: AppValidators.validateEmail,
/// ),
///
/// TextFormField(
///   decoration: const InputDecoration(labelText: "Password"),
///   obscureText: true,
///   validator: AppValidators.validatePassword,
/// ),
///
/// TextFormField(
///   decoration: const InputDecoration(labelText: "Phone"),
///   validator: AppValidators.validatePhone,
/// ),
/// 
