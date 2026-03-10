import 'package:sams_app/core/cache/get_storage.dart';
import 'package:sams_app/core/utils/constants/cache_keys.dart';

enum UserRole {
  instructor,
  student
  ;

  static UserRole fromString(String role) {
    return UserRole.values.firstWhere(
      (e) => e.name.toLowerCase() == role.toLowerCase(),
      orElse: () => UserRole.student, // Default value when no match is found
    );
  }
}

class CurrentRole {
  CurrentRole._();

  static UserRole get role {
    final roleString = GetStorageHelper.read<String>(CacheKeys.role);

    // If roleString is null, fromString will return the default (student)
    return UserRole.fromString(roleString ?? '');
  }
}
