import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/features/profile/data/repos/profile_repo.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

 //? Fetches the user's profile data.
  ///
  /// Emits [ProfileLoading] while fetching, and either [ProfileSuccess] with the user's profile
  /// or [ProfileFailure] with an error message.
  Future<void> getUserProfile() async {
    emit(ProfileLoading());

    final result = await profileRepo.getUserProfile();

    result.fold(
      (failure) => emit(ProfileFailure(failure)),
      (userModel) => emit(ProfileSuccess(userModel)),
    );
  }

  //? Uploads the user's profile picture.
  ///
  /// Emits [UploadProfilePicLoading] while uploading, and either [UploadProfilePicSuccess] with the
  /// updated user's profile or [UploadProfilePicFailure] with an error message.
  Future<void> uploadProfileImage(XFile imageFile) async {
    emit(UploadProfilePicLoading(0)); 

    final result = await profileRepo.uploadProfilePicture(imageFile);

    result.fold(
      (failure) {
        emit(UploadProfilePicFailure(failure));
      },
      (user) {
        emit(UploadProfilePicSuccess(user));
      },
    );
  }
}
