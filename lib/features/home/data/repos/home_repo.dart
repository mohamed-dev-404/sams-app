import 'package:dartz/dartz.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';

//* Abstract contract for home data operations
abstract class HomeRepo {
  //* Returns cached courses from local storage
  List<CourseModel> getCachedCourses();

  //* Fetch courses based on user role
  Future<Either<String, List<CourseModel>>> fetchMyCourses({
    required UserRole role,
  });

  //? POST → create a new course with grade structure
  Future<Either<String, String>> createCourse({
    required CreateCourseModel course,
  });

  //? POST → join a course via invitation code
  Future<Either<String, String>> joinCourse({
    required JoinCourseModel model,
  });

  //! DELETE → unenroll from a course by ID
  Future<Either<String, String>> removeCourse({
    required UserRole role,
    required String courseId,
  });
}
