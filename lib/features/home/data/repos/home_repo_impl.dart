import 'package:dartz/dartz.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiConsumer api;

  HomeRepoImpl({required this.api});

   //? Fetches courses based on the user role.
  ///
  /// Uses the role-specific endpoint to get the user's courses
  /// and converts the response into a list of [CourseModel].
  /// Returns either a failure message or a list of courses.
  @override
  Future<Either<String, List<CourseModel>>> fetchMyCourses({
    required UserRole role,
  }) async {
    try {
      var response = await api.get(role.myCoursesEndpoint);

      List<CourseModel> courses =
          (response['data'] as List?)
              ?.map((item) => CourseModel.fromJson(item))
              .toList() ??
          [];

      return right(courses);
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }
   //! Creates a new course.
  ///
  /// Sends [CreateCourseModel] data to the API.
  /// Returns success message if created successfully,
  /// otherwise returns an error message.
  @override
  Future<Either<String, String>> createCourse({
    required CreateCourseModel course,
  }) async {
    try {
      final response = await api.post(
        EndPoints.createCourse,
        data: course.toJson(),
      );
      return right(response['message'] ?? 'Course Created Successfully');
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

   //* Joins a course using an invitation code.
  ///
  /// Sends [JoinCourseModel] data to the API.
  /// Returns success message if joining succeeds,
  /// otherwise returns an error message.
  @override
  Future<Either<String, String>> joinCourse({
    required JoinCourseModel model,
  }) async {
    try {
      var response = await api.post(
        EndPoints.joinCourse,
        data: model.toJson(),
      );

      return right(response['message'] ?? 'Joined successfully');
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }
  
}