import 'package:dartz/dartz.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/extentions/user_role_endpoint_extension.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/features/home/data/data_sources/home_local_data_sourse.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';

//* Handles all home-related API calls and local caching
class HomeRepoImpl implements HomeRepo {
  final ApiConsumer api;
  final HomeLocalDataSource localDataSource;

  HomeRepoImpl({required this.api, required this.localDataSource});

  //* GET courses by role → cache locally → return list
  @override
  Future<Either<String, List<CourseModel>>> fetchMyCourses({
    required UserRole role,
  }) async {
    try {
      var response = await api.get(role.myCoursesEndpoint);

      List<CourseModel> courses =
          (response[ApiKeys.data] as List?)
              ?.map((item) => CourseModel.fromJson(item))
              .toList() ??
          [];

      await localDataSource.cacheCourses(courses);

      return right(courses);
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  //? POST → create course and return success message
  @override
  Future<Either<String, String>> createCourse({
    required CreateCourseModel course,
  }) async {
    try {
      final response = await api.post(
        EndPoints.createCourse,
        data: course.toJson(),
      );
      return right(response[ApiKeys.message] ?? 'Course Created Successfully');
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  //? POST → join course via invitation code and return success message
  @override
  Future<Either<String, String>> joinCourse({
    required JoinCourseModel model,
  }) async {
    try {
      var response = await api.post(
        EndPoints.joinCourse,
        data: model.toJson(),
      );

      return right(response[ApiKeys.message] ?? 'Joined successfully');
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  //! DELETE → unenroll from course by role and course ID
  @override
  Future<Either<String, String>> removeCourse({
    required UserRole role,
    required String courseId,
  }) async {
    try {
      final response = await api.delete(role.removeCourseEndpoint(courseId));

      return right(response[ApiKeys.message] ?? 'Unenrolled successfully');
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  //* Returns courses from local cache without network call
  @override
  List<CourseModel> getCachedCourses() {
    return localDataSource.getCachedCourses();
  }
}
