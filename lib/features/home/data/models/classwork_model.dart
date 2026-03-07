import 'package:sams_app/core/utils/constants/api_keys.dart';

class ClassworkModel {
  final String name;
  final double points;

  ClassworkModel({
    required this.name,
    required this.points,
  });

  factory ClassworkModel.fromJson(Map<String, dynamic> json) {
    return ClassworkModel(
      name: json[ApiKeys.name] ?? '',
      points: (json[ApiKeys.points] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.points: points,
    };
  }
}
