import 'package:sams_app/core/utils/constants/api_endpoints.dart';

enum UserRole {
  teacher,
  student,
}


extension UserRoleEndpointExtension on UserRole {
  String get myCoursesEndpoint {
    switch (this) {
      case UserRole.teacher:
        return EndPoints.getMyCreatedCourses;
      case UserRole.student:
        return EndPoints.getMyJoinedCourses;
    }
  }
}
