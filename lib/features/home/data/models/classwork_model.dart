class ClassworkModel {
  final String name;
  final double points;

  ClassworkModel({
    required this.name,
    required this.points,
  });

  factory ClassworkModel.fromJson(Map<String, dynamic> json) {
    return ClassworkModel(
      name: json['name'] ?? '',
      points: (json['points'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'points': points,
    };
  }
}
