import 'package:sams_app/features/home/data/models/classwork_model.dart';

class CreateCourseModel {
  final String name;
  final String academicCode;
  final double totalGrades;
  final double finalExam;
  final List<ClassworkModel> classwork;

  CreateCourseModel({
    required this.name,
    required this.academicCode,
    required this.totalGrades,
    required this.finalExam,
    required this.classwork,
  });

  factory CreateCourseModel.fromJson(Map<String, dynamic> json) {
    return CreateCourseModel(
      name: json['name'] ?? '',
      academicCode: json['academicCourseCode'] ?? '',
      totalGrades: (json['totalGrades'] ?? 0).toDouble(),
      finalExam: (json['finalExam'] ?? 0).toDouble(),
      classwork:
          (json['classwork'] as List?)
              ?.map((item) => ClassworkModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'academicCourseCode': academicCode,
      'totalGrades': totalGrades,
      'finalExam': finalExam,
      'classwork': classwork.map((e) => e.toJson()).toList(),
    };
  }
}
