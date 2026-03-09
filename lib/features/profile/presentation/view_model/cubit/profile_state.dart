import 'package:sams_app/features/profile/data/models/user_model.dart';

//* Base state for Profile feature.
sealed class ProfileState {}

/// Initial state when the profile page is first created.
final class ProfileInitial extends ProfileState {}

//? Emitted while fetching user profile data from the server.
final class ProfileLoading extends ProfileState {}

//* Emitted when user profile data is retrieved successfully.
//* Contains the [UserModel] with all user details.
final class ProfileSuccess extends ProfileState {
  final UserModel userModel;
  ProfileSuccess(this.userModel);
}

//! Emitted when fetching profile data fails.
//! Contains the [errMessage] to be displayed to the user.
final class ProfileFailure extends ProfileState {
  final String errMessage;
  ProfileFailure(this.errMessage);
}




//* Base state for profile actions (upload, update, etc.)
sealed class ProfileActionState extends ProfileState {}


//? Emitted while uploading profile picture.
final class UploadProfilePicLoading extends ProfileActionState {
  final double progress;
  UploadProfilePicLoading(this.progress);
}

//* Emitted when profile picture upload is successful.
//* Contains the [UserModel] with updated profile picture.
final class UploadProfilePicSuccess extends ProfileActionState {
  final UserModel userModel;
  UploadProfilePicSuccess(this.userModel);
}

//! Emitted when profile picture upload fails.
//! Contains the [errMessage] to be displayed to the user.
final class UploadProfilePicFailure extends ProfileActionState {
  final String errMessage;
  UploadProfilePicFailure(this.errMessage);
}