import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? academicEmail;
  final String? academicId;
  final String? profilePic; 

  const UserModel({
    this.id,
    this.name,
    this.academicEmail,
    this.academicId,
    this.profilePic,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
    id: data['_id'] as String?,
    name: data['name'] as String?,
    academicEmail: data['academicEmail'] as String?,
    academicId: data['academicId'] as String?,
    profilePic: data['profilePic'] as String?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
    'academicEmail': academicEmail,
    'academicId': academicId,
    'profilePic': profilePic,
  };

  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  UserModel copyWith({
    String? id,
    String? name,
    String? academicEmail,
    String? academicId,
    String? profilePic,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      academicEmail: academicEmail ?? this.academicEmail,
      academicId: academicId ?? this.academicId,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  @override
  List<Object?> get props => [id, name, academicEmail, academicId, profilePic];
}
