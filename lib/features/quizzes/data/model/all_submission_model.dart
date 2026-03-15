import 'package:intl/intl.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';

enum SubmissionStatus { marked, unmarked }

class AllSubmissionModel {
  final String id;
  final String quizId;
  final String academicId;
  final String studentName;
  final int score;
  final DateTime submittedAt;
  final bool isGraded;

  const AllSubmissionModel({
    required this.id,
    required this.quizId,
    required this.academicId,
    required this.studentName,
    required this.score,
    required this.submittedAt,
    required this.isGraded,
  });

  //! --- Display Getters (for UI) ---

  /// Formats the date to match UI (e.g., "12:59 PM")
  String get formattedTime => DateFormat('hh:mm a').format(submittedAt);

  /// Automatically returns the correct score string (e.g., "10" or "-")
  /// In the UI, you can just do: "${submission.displayScore}/10"
  String get displayScore => isGraded ? score.toString() : '-';

  //! --- Logic Getters ---

  /// Returns the enum state matching your UI summary tabs
  SubmissionStatus get status =>
      isGraded ? SubmissionStatus.marked : SubmissionStatus.unmarked;

  factory AllSubmissionModel.fromJson(Map<String, dynamic> json) {
    return AllSubmissionModel(
      id: json[ApiKeys.id] ?? '',
      quizId: json[ApiKeys.quizId] ?? '',
      academicId: json[ApiKeys.academicId] ?? '',
      studentName: json[ApiKeys.studentName] ?? 'Unknown Student',
      score: json[ApiKeys.score] ?? 0,
      // Safely parse the ISO 8601 string
      submittedAt:
          DateTime.tryParse(json[ApiKeys.submittedAt] ?? '') ?? DateTime.now(),
      isGraded: json[ApiKeys.isGraded] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.quizId: quizId,
      ApiKeys.academicId: academicId,
      ApiKeys.studentName: studentName,
      ApiKeys.score: score,
      ApiKeys.submittedAt: submittedAt.toIso8601String(),
      ApiKeys.isGraded: isGraded,
    };
  }
}
