import 'package:sams_app/core/utils/constants/api_keys.dart';

///! Represents the visual state of the overall question card in the UI
enum QuestionUIState {
  correct, // Green border (MCQ/TF)
  incorrect, // Red border (MCQ/TF)
  marked, // Green border (Graded Essay)
  unmarked, // Yellow border (Ungraded Essay)
}

///! Represents the visual state of an individual MCQ/TF option
enum OptionUIState {
  correct, // Green (Correct answer, whether selected or not)
  wrongSelected, // Red (Wrong answer, but student selected it)
  unselected, // Default (Wrong answer, student did not select it)
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

  //! --- UI Getters ---

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

  ///* Determines the exact UI state for colors and borders of the overall question card
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
    } else if (parsedQuestionType == ApiValues.mcq ||
        parsedQuestionType == ApiValues.trueFalse) {
      parsedSelectedOptionId = json[ApiKeys.selectedOptionId];

      if (json[ApiKeys.options] != null) {
        parsedOptions = (json[ApiKeys.options] as List).map((eachOption) {
          // Check if this specific option's ID matches the selectedOptionId
          final String optionId = eachOption[ApiKeys.id] ?? '';
          final bool isSelected = optionId == parsedSelectedOptionId;

          // Pass the result directly into the option model
          return AnswerOptionModel.fromJson(eachOption, isSelected: isSelected);
        }).toList();
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

///! Helper model for MCQ and True/False options
class AnswerOptionModel {
  final String id;
  final String text;
  final bool isCorrect;
  final bool isSelected; // Tracks if the student picked this option

  const AnswerOptionModel({
    required this.id,
    required this.text,
    required this.isCorrect,
    required this.isSelected,
  });

  //! --- UI Getter ---
  OptionUIState get state {
    // 1. If it's the correct answer, it's ALWAYS green.
    if (isCorrect) return OptionUIState.correct;

    // 2. If it's wrong AND the student selected it, it's red.
    if (isSelected) return OptionUIState.wrongSelected;

    // 3. Otherwise, it's just a wrong answer they didn't pick (default).
    return OptionUIState.unselected;
  }

  factory AnswerOptionModel.fromJson(
    Map<String, dynamic> json, {
    required bool isSelected,
  }) {
    return AnswerOptionModel(
      id: json[ApiKeys.id] ?? '',
      text: json[ApiKeys.text] ?? '',
      isCorrect: json[ApiKeys.isCorrect] ?? false,
      isSelected: isSelected, // Injected from the parent model
    );
  }
}
