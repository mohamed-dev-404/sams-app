import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/mixins/safe_emit_mixin.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/data/repos/profile_repo.dart';
import 'package:sams_app/core/utils/mixins/cubit_message_mixin.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';

class ProfileCubit extends HydratedCubit<ProfileState> with  CubitMessageMixin,SafeEmitMixin
 {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());


 //? Fetches the user's profile data.
  ///
  /// Emits [ProfileLoading] while fetching, and either [ProfileSuccess] with the user's profile
  /// or [ProfileFailure] with an error message.
  Future<void> getUserProfile() async {

   if (state is! ProfileSuccess) {
      emit(ProfileLoading());
    }

    final result = await profileRepo.getUserProfile();
    
    if (isClosed) return;

    result.fold(
      (failure) {
        if (state is ProfileSuccess) {
          emitMessage(failure);
        } else {
          emit(ProfileFailure(failure));
        }
      },
      (userModel) => emit(ProfileSuccess(userModel)),
    );
  }

 @override
  Future<void> close() {
    closeMessages();
    return super.close();
  }
  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    if (state is ProfileSuccess) {
      return state.userModel.toMap(); 
    }
    return null;
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    try {
      final user = UserModel.fromMap(json);
      return ProfileSuccess(user);
    } catch (_) {
      return null;
    }
  }


  //? Uploads the user's profile picture.
  ///
  /// Emits [UploadProfilePicLoading] while uploading, and either [UploadProfilePicSuccess] with the
  /// updated user's profile or [UploadProfilePicFailure] with an error message.
  Future<void> uploadProfileImage(XFile imageFile) async {
    emit(UploadProfilePicLoading(0)); 

    if (isClosed) return;

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

