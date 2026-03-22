import 'package:dartz/dartz.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final ApiConsumer api;

  QuizRepositoryImpl({required this.api});

  // --- Discovery Flow ---
  @override
  Future<Either<String, List<QuizModel>>> getQuizzesForCourse(
    String courseId,
  ) async {
    try {
      // 1. Fetch data from the endpoint
      final response = await api.get(EndPoints.getCourseQuizzes(courseId));

      // 2. Parse the response
      List<QuizModel> quizzes = (response[ApiKeys.data] as List)
          .map((quizJson) => QuizModel.fromJson(quizJson))
          .toList();

      return Right(quizzes);
    } on ApiException catch (e) {
      // Handle known API exceptions mapped by the interceptor
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      // Handle unexpected runtime exceptions
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, dynamic>> getQuizDetails(String quizId) async {
    // TODO: implement getQuizDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<dynamic>>> getQuizQuestions(String quizId) async {
    // TODO: implement getQuizQuestions
    throw UnimplementedError();
  }

  // --- Instructor Flow: Quiz CRUD ---

  @override
  Future<Either<String, String>> createQuiz(
    String courseId,
    Map<String, dynamic> data,
  ) async {
    // TODO: implement createQuiz
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> updateQuiz(
    String quizId,
    Map<String, dynamic> data,
  ) async {
    // TODO: implement updateQuiz
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> deleteQuiz(String quizId) async {
    // TODO: implement deleteQuiz
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> toggleQuizPublished(String quizId) async {
    // TODO: implement toggleQuizPublished
    throw UnimplementedError();
  }

  // --- Instructor Flow: Questions CRUD ---

  @override
  Future<Either<String, String>> addQuestion(
    String quizId,
    Map<String, dynamic> data,
  ) async {
    // TODO: implement addQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> updateQuestion(
    String questionId,
    Map<String, dynamic> data,
  ) async {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> deleteQuestion(String questionId) async {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }

  // --- Student Flow: Taking Quizzes ---

  @override
  Future<Either<String, String>> submitQuiz(
    String quizId,
    Map<String, dynamic> data,
  ) async {
    // TODO: implement submitQuiz
    throw UnimplementedError();
  }

  // --- Instructor Flow: Grading ---

  @override
  Future<Either<String, List<dynamic>>> getQuizSubmissions(
    String quizId,
  ) async {
    // TODO: implement getQuizSubmissions
    throw UnimplementedError();
  }

  @override
  Future<Either<String, dynamic>> getSubmissionDetails(
    String submissionId,
  ) async {
    // TODO: implement getSubmissionDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> gradeSubmissionQuestion(
    String submissionId,
    String questionId,
    Map<String, dynamic> data,
  ) async {
    // TODO: implement gradeSubmissionQuestion
    throw UnimplementedError();
  }
}
