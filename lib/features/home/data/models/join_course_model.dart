import 'package:sams_app/core/utils/constants/api_keys.dart';

class JoinCourseModel {
  final String invitationCode;

  JoinCourseModel({required this.invitationCode});

  Map<String, dynamic> toJson() => {
    ApiKeys.courseInvitationCode: invitationCode,
  };
}
