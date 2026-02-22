import 'package:dartz/dartz.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';

abstract class HomeRepo {
  Future<Either<String, List<CourseModel>>> fetchMyCourses({
    required UserRole role,
  });

  Future<Either<String, String>> createCourse({
    required CreateCourseModel course,
  });

  Future<Either<String, String>> joinCourse({
    required JoinCourseModel model,
  });

  Future<Either<String, String>> unEnrollCourse({
    required String courseId,
  });
}
