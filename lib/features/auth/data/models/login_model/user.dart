import 'package:equatable/equatable.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';

class User extends Equatable {
  final String? name;
  final String? academicEmail;
  final String? profilePic;

  const User({this.name, this.academicEmail, this.profilePic});

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json[ApiKeys.name] as String?,
    academicEmail: json[ApiKeys.academicEmail] as String?,
    profilePic: json[ApiKeys.profilePic] as String?,
  );

  Map<String, dynamic> toJson() => {
    ApiKeys.name: name,
    ApiKeys.academicEmail: academicEmail,
    ApiKeys.profilePic: profilePic,
  };

  @override
  List<Object?> get props => [name, academicEmail, profilePic];
}
