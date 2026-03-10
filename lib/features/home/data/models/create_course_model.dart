import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/features/home/data/models/classwork_model.dart';

//* Request model for creating a new course with grade structure
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
      name: json[ApiKeys.name] ?? '',
      academicCode: json[ApiKeys.academicCourseCode] ?? '',
      totalGrades: (json[ApiKeys.totalGrades] ?? 0).toDouble(),
      finalExam: (json[ApiKeys.finalExam] ?? 0).toDouble(),
      classwork:
          (json[ApiKeys.classwork] as List?)
              ?.map((item) => ClassworkModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.academicCourseCode: academicCode,
      ApiKeys.totalGrades: totalGrades,
      ApiKeys.finalExam: finalExam,
      ApiKeys.classwork: classwork.map((e) => e.toJson()).toList(),
    };
  }
}
