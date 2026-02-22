import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo, {required this.role}) : super(HomeInitial());

  final HomeRepo homeRepo;
  final UserRole role;

  //? Fetches the list of courses for the current user based on their [role].
  ///
  /// Emits [HomeLoading] while fetching, and either [HomeSuccess] with the courses
  /// or [HomeFailure] with an error message.
  Future<void> fetchMyCourses({required UserRole role}) async {
    emit(HomeLoading());

    final result = await homeRepo.fetchMyCourses(role: role);

    result.fold(
      (failure) => emit(HomeFailure(failure)),
      (courses) => emit(HomeSuccess(courses)),
    );
  }
  
  //* Creates a new course as an Instructor.
  ///
  /// Takes a [CreateCourseModel] containing course details.
  /// If successful, re-fetches the courses list and emits [CreateCourseSuccess].
  Future<void> createCourse({required CreateCourseModel course}) async {
    emit(CreateCourseLoading());

    final result = await homeRepo.createCourse(course: course);

    result.fold(
      (failure) => emit(CreateCourseFailure(failure)),
      (message) async {
        await fetchMyCourses(role: role);

        emit(CreateCourseSuccess(message));
      },
    );
  }

  //* Joins an existing course as a Student using an invitation code.
  ///
  /// Sends [JoinCourseModel] data to the repository.
  /// If successful, re-fetches the user's courses and emits [JoinCourseSuccess].
  Future<void> joinCourse({required JoinCourseModel model}) async {
    emit(JoinCourseLoading());

    final result = await homeRepo.joinCourse(model: model);

    result.fold(
      (failure) => emit(JoinCourseFailure(failure)),
      (message) async {
        await fetchMyCourses(role: role);

        emit(JoinCourseSuccess(message));
      },
    );
  }
}
