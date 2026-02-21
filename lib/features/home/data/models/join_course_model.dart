class JoinCourseModel {
  final String invitationCode;

  JoinCourseModel({required this.invitationCode});

  Map<String, dynamic> toJson() => {
    'courseInvitationCode': invitationCode,
  };
}
