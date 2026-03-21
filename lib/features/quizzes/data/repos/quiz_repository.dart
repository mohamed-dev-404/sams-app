import 'package:dartz/dartz.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/question_model.dart';
import 'package:sams_app/features/quizzes/data/model/request_bodies_models/submit_quiz/quiz_answer_model.dart';

abstract class QuizRepository {
  // --- Discovery Flow ---
  Future<Either<String, List<dynamic>>> getQuizzesForCourse(String courseId);
  Future<Either<String, dynamic>> getQuizDetails(String quizId);
  Future<Either<String, List<QuestionModel>>> getQuizQuestions(String quizId);

  // --- Instructor Flow: Quiz CRUD ---
  Future<Either<String, String>> createQuiz(
    String courseId,
    Map<String, dynamic> data,
  );
  Future<Either<String, String>> updateQuiz(
    String quizId,
    Map<String, dynamic> data,
  );
  Future<Either<String, String>> deleteQuiz(String quizId);
  Future<Either<String, String>> toggleQuizPublished(String quizId);

  // --- Instructor Flow: Questions CRUD ---
  Future<Either<String, String>> addQuestion(
    String quizId,
    Map<String, dynamic> data,
  );
  Future<Either<String, String>> updateQuestion(
    String questionId,
    Map<String, dynamic> data,
  );
  Future<Either<String, String>> deleteQuestion(String questionId);

  // --- Student Flow: Taking Quizzes ---
  Future<Either<String, String>> submitQuiz(
    String quizId,
    List<QuizAnswerModel> answers,
  );

  // --- Instructor Flow: Grading ---
  Future<Either<String, List<dynamic>>> getQuizSubmissions(String quizId);
  Future<Either<String, dynamic>> getSubmissionDetails(String submissionId);
  Future<Either<String, String>> gradeSubmissionQuestion(
    String submissionId,
    String questionId,
    Map<String, dynamic> data,
  );
}
