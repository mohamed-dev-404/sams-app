import 'package:flutter_bloc/flutter_bloc.dart';
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
}
