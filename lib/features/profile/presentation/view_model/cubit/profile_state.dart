import 'package:sams_app/features/profile/data/models/user_model.dart';

//* Base state for Profile feature.
abstract class ProfileState {}

/// Initial state when the profile page is first created.
class ProfileInitial extends ProfileState {}

//? Emitted while fetching user profile data from the server.
class ProfileLoading extends ProfileState {}

//* Emitted when user profile data is retrieved successfully.
//* Contains the [UserModel] with all user details.
class ProfileSuccess extends ProfileState {
  final UserModel userModel;
  ProfileSuccess(this.userModel);
}

//! Emitted when fetching profile data fails.
//! Contains the [errMessage] to be displayed to the user.
class ProfileFailure extends ProfileState {
  final String errMessage;
  ProfileFailure(this.errMessage);
}
