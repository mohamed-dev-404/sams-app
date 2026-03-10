class CourseHeaderCardModel {
  final String title;
  final String? description;
  final String? instructor;
  CourseHeaderCardModel({
    this.description,
    required this.title,
    this.instructor,
  });
}
