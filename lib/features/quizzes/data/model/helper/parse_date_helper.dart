import 'package:intl/intl.dart';

/// Converts a string to DateTime, handling ISO 8601 and custom backend formats.
DateTime parseDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return DateTime.now();

  // 1. Try Standard ISO 8601
  var parsed = DateTime.tryParse(dateStr);
  if (parsed != null) return parsed.toLocal();

  // 2. Try Custom Backend Format (M/d/yyyy, h:mm:ss a)
  try {
    return DateFormat('M/d/yyyy, h:mm:ss a').parse(dateStr, true).toLocal();
  } catch (e) {
    return DateTime.now();
  }
}
