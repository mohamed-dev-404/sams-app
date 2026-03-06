import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';

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
