//! Course Model Class For Home Screen 
class CourseModel {
  final String id;
  final String name;
  final String academicCourseCode;
  final String instructor;
  final String? courseInvitationCode;

  CourseModel({
    required this.id,
    required this.name,
    required this.academicCourseCode,
    required this.instructor,
    this.courseInvitationCode,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: (json['_id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      academicCourseCode: (json['academicCourseCode'] as String?) ?? '',
      instructor: (json['instructor'] as String?) ?? '',
      courseInvitationCode: json['courseInvitationCode'] as String?,
    );
  }

  
  CourseModel copyWith({
    String? id,
    String? name,
    String? academicCourseCode,
    String? instructor,
    String? courseInvitationCode,
  }) {
    return CourseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      academicCourseCode: academicCourseCode ?? this.academicCourseCode,
      instructor: instructor ?? this.instructor,
      courseInvitationCode: courseInvitationCode ?? this.courseInvitationCode,
    );
  }
}
