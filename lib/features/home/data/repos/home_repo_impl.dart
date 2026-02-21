import 'package:dartz/dartz.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiConsumer api;

  HomeRepoImpl({required this.api});

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
  
  @override
  Future<Either<String, String>> createCourse({
    required CreateCourseModel course,
  }) async {
    try {
      final response = await api.post(
        'instructor/courses',
        data: course.toJson(),
      );
      return right(response['message'] ?? 'Course Created Successfully');
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }
}