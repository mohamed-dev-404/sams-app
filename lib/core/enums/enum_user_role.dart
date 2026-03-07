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
  static const role = UserRole.instructor;
}
