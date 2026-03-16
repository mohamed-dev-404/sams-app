class RoutesName {
  RoutesName._();

  //? home routes
  static const String courses = '/courses';
  static const String createCourse = '/createCourse';

//? profile routes
  static const String profile = '/profile';

//? course details routes
  static const String materials = 'materials';
  static const String assignments = 'assignments';
  static const String announcements = 'announcements';
  static const String grades = 'grades';
  static const String quizzes = 'quizzes';
  
  //? Quiz sub-routes
  static const String quizDetails = 'quizDetails'; // e.g., /courses/:courseId/quizzes/:quizId
  static const String createQuiz = 'createQuiz';
  static const String manageQuestions = 'manageQuestions'; // e.g., .../quizzes/:quizId/questions
  static const String takeQuiz = 'takeQuiz';
  static const String submissionsList = 'submissionsList'; // e.g., .../quizzes/:quizId/submissions
  static const String gradeSubmission = 'gradeSubmission'; // e.g., .../submissions/:submissionId

  static const String liveSessions = 'liveSessions';
  static const String courseCode = 'courseCode';
  static const String membersList = 'membersList';

  //?auth routes
  //login
  static const String login = '/login';
  //sign up
  static const String signUp = '/signUp';
  static const String activateAccount = '/auth/activateAccount';
  // Password Reset Flow Paths
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/reset-password';
}
