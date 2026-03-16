import 'package:sams_app/core/utils/constants/api_keys.dart';

class ClassworItemkModel {
  final String id;
  final String name;
  final int points;
  final bool isVisible;

  const ClassworItemkModel({
    required this.id,
    required this.name,
    required this.points,
    required this.isVisible,
  });

  //! --- Serialization ---

  factory ClassworItemkModel.fromJson(Map<String, dynamic> json) {
    return ClassworItemkModel(
      id: json[ApiKeys.id] ?? '',
      name: json[ApiKeys.name] ?? '',
      points: json[ApiKeys.points] ?? 0,
      isVisible: json[ApiKeys.isVisible] ?? false,
    );
  }
}
