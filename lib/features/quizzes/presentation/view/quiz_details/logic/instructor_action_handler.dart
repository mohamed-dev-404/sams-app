import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'quiz_action_type.dart';

class InstructorActionHandler {
  // Main execution method
  static void execute({
    required BuildContext context,
    required QuizActionType action,
    required QuizModel quiz,
  }) {
    switch (action) {
      case QuizActionType.addQuestions:
        _navigateToAddQuestions(context, quiz);
        break;
      case QuizActionType.manageQuestions:
        _navigateToManageQuestions(context, quiz);
        break;
      case QuizActionType.viewQuestions:
        _navigateToViewQuestions(context, quiz);
        break;
      case QuizActionType.viewSubmissions:
        _navigateToSubmissions(context, quiz);
        break;
    }
  }

  // Navigation Logic Placeholders
  static void _navigateToAddQuestions(BuildContext context, QuizModel quiz) {
    log('Navigating to Add Questions for quiz: ${quiz.id}');
    // TODO: Add GoRouter or Navigator logic here
  }

  static void _navigateToManageQuestions(BuildContext context, QuizModel quiz) {
    log('Navigating to Manage Questions for quiz: ${quiz.id}');
  }

  static void _navigateToViewQuestions(BuildContext context, QuizModel quiz) {
    log('Navigating to View Questions for quiz: ${quiz.id}');
  }

  static void _navigateToSubmissions(BuildContext context, QuizModel quiz) {
    log('Navigating to Submissions for quiz: ${quiz.id}');
  }
}
