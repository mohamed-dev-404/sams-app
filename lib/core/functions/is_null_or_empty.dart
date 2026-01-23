bool isNullOrEmpty(String? value) {
  return value == null || value.trim().isEmpty;
}

/// Usage:
/// if (isNullOrEmpty(name)) print('Name is null');
