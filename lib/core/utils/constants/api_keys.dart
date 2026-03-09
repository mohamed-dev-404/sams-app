class ApiKeys {
  ApiKeys._();

  //? --- Common Response & General Keys ---
  static const String data = 'data';
  static const String message = 'message';
  static const String status = 'status';
  static const String validationErrors = 'validationErrors';
  static const String id = '_id';

  //? --- User & Profile Keys ---
  static const String name = 'name';
  static const String academicEmail = 'academicEmail';
  static const String academicId = 'academicId';
  static const String profilePic = 'profilePic';

  //? --- Image & S3 Upload Keys ---
  static const String originalFileName = 'originalFileName';
  static const String contentType = 'contentType';
  static const String fileSize = 'fileSize';
  static const String key = 'key';
  static const String uploadUrl = 'uploadUrl';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentLengthHeader = 'Content-Length';

  //? --- Course & Home Keys ---
  static const String academicCourseCode = 'academicCourseCode';
  static const String instructor = 'instructor';
  static const String courseInvitationCode = 'courseInvitationCode';
  static const String totalGrades = 'totalGrades';
  static const String finalExam = 'finalExam';
  static const String classwork = 'classwork';
  static const String points = 'points';
}