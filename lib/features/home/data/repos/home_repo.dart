import 'package:dartz/dartz.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';

abstract class HomeRepo {
  Future<Either<String, List<CourseModel>>> fetchMyCourses({
    required UserRole role,
  });

}
