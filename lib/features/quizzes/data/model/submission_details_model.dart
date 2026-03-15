import 'package:sams_app/core/utils/constants/api_keys.dart';

///! Represents the visual state of the question card in the UI
enum QuestionUIState {
  correct, // Green border (MCQ/TF)
  incorrect, // Red border (MCQ/TF)
  marked, // Green border (Graded Essay)
  unmarked, // Yellow border (Ungraded Essay)
}

class SubmissionDetailsModel {
  final String id;
  final String text;
  final String questionType;
  final int timeLimit;
  final int points;
  final int earnedPoints;
  final bool? isCorrect; // Null specifically means pending manual grading

  // MCQ & TF specific fields
  final List<AnswerOptionModel>? options;
  final String? selectedOptionId;

  // Written specific field
  final String? writtenAnswer;

  const SubmissionDetailsModel({
    required this.id,
    required this.text,
    required this.questionType,
    required this.timeLimit,
    required this.points,
    required this.earnedPoints,
    this.isCorrect,
    this.options,
    this.selectedOptionId,
    this.writtenAnswer,
  });

  //! --- Clean UI Getters (KISS) ---

  ///* Returns the text for the top-left badge (e.g., "Multiple Choice")
  String get uiTypeLabel {
    switch (questionType) {
      case ApiValues.mcq:
        return 'Multiple Choice';
      case ApiValues.trueFalse:
        return 'True or False';
      case ApiValues.written:
        return 'Essay';
      default:
        return 'Unknown';
    }
  }

  ///* Automatically formats the score string for the top-right badge (e.g., "1/1", "0/2", "-/3")
  String get displayScore {
    // If it's a written question AND isCorrect is null, it hasn't been graded yet.
    if (questionType == ApiValues.written && isCorrect == null) {
      return '-/$points';
    }
    return '$earnedPoints/$points';
  }

  ///* Determines the exact UI state for colors and borders
  QuestionUIState get state {
    if (questionType == ApiValues.written) {
      // If isCorrect is false here, it means the student left it empty (auto 0 points).
      // If isCorrect is null, it requires the instructor to grade it.
      return isCorrect == null
          ? QuestionUIState.unmarked
          : QuestionUIState.marked;
    } else {
      // Auto-graded questions (MCQ / TF)
      return (isCorrect ?? false)
          ? QuestionUIState.correct
          : QuestionUIState.incorrect;
    }
  }

  //! --- Serialization ---

  factory SubmissionDetailsModel.fromJson(Map<String, dynamic> json) {
    // 1. Extract the question type first to determine how to parse the rest
    final String parsedQuestionType = json[ApiKeys.questionType] ?? '';

    // 2. Initialize type-specific fields as null
    List<AnswerOptionModel>? parsedOptions;
    String? parsedSelectedOptionId;
    String? parsedWrittenAnswer;

    // 3. Safely parse ONLY the fields that belong to this specific question type
    if (parsedQuestionType == ApiValues.written) {
      parsedWrittenAnswer = json[ApiKeys.writtenAnswer];
    } else if (parsedQuestionType == ApiValues.mcq || parsedQuestionType == ApiValues.trueFalse) {
      parsedSelectedOptionId = json[ApiKeys.selectedOptionId];
      
      if (json[ApiKeys.options] != null) {
        parsedOptions = (json[ApiKeys.options] as List)
            .map((e) => AnswerOptionModel.fromJson(e))
            .toList();
      }
    }

    // 4. Construct and return the clean object
    return SubmissionDetailsModel(
      id: json[ApiKeys.id] ?? '',
      text: json[ApiKeys.text] ?? '',
      questionType: parsedQuestionType,
      timeLimit: json[ApiKeys.timeLimit] ?? 0,
      points: json[ApiKeys.points] ?? 0,
      earnedPoints: json[ApiKeys.earnedPoints] ?? 0,
      isCorrect: json[ApiKeys.isCorrect], // Keep nullable for pending grades
      
      // Inject the safely parsed variables
      options: parsedOptions,
      selectedOptionId: parsedSelectedOptionId,
      writtenAnswer: parsedWrittenAnswer,
    );
  }
}

///? Helper model for MCQ and True/False options
class AnswerOptionModel {
  final String id;
  final String text;
  final bool isCorrect;

  const AnswerOptionModel({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) {
    return AnswerOptionModel(
      id: json[ApiKeys.id] ?? '',
      text: json[ApiKeys.text] ?? '',
      isCorrect: json[ApiKeys.isCorrect] ?? false,
    );
  }
}
