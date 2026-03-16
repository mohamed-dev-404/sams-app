import 'package:sams_app/core/utils/constants/api_keys.dart';

class CreateQuizRequestBody {
  final String? classworkId;
  final String? title;
  final String? description;
  final DateTime? startTime; // Stored as DateTime for UI convenience
  final int? duration;

  const CreateQuizRequestBody({
    this.classworkId,
    this.title,
    this.description,
    this.startTime,
    this.duration,
  });

  //! --- Serialization ---

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (classworkId != null) data[ApiKeys.classworkId] = classworkId;
    if (title != null) data[ApiKeys.title] = title;
    if (description != null) data[ApiKeys.description] = description;

    // Converts DateTime to ISO 8601 String for the backend (e.g., 2026-02-18T16:15:00.000)
    if (startTime != null) {
      data[ApiKeys.startTime] = startTime!.toIso8601String();
    }

    if (duration != null) data[ApiKeys.duration] = duration;

    return data;
  }
}
