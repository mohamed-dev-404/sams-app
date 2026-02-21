class EnrollCourseModel {
  final String invitationCode;

  EnrollCourseModel({required this.invitationCode});

  Map<String, dynamic> toJson() => {
    'courseInvitationCode': invitationCode,
  };
}
