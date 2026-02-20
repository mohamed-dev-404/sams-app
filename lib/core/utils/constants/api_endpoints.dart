class EndPoints {
  EndPoints._();

  //? EndPoints

   //! --- Home  --- ;
   //* Instructor endpoints
  static const String createCourse = 'instructor/courses';
  static const String getMyCreatedCourses = 'instructor/courses/me';

  //* Enrollment endpoints
  static const String getMyJoinedCourses = 'enrollments/me';
  static const String joinCourse = 'enrollments'; 
  static String unenrollCourse(String courseId) =>
      'enrollments/my-courses/$courseId';

}
