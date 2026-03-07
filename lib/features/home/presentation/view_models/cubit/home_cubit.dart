import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/mixins/safe_emit_mixin.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';
import 'package:sams_app/core/utils/mixins/cubit_message_mixin.dart';

class HomeCubit extends Cubit<HomeState> with CubitMessageMixin, SafeEmitMixin {
  HomeCubit(this.homeRepo, {required this.role}) : super(HomeInitial());

  final HomeRepo homeRepo;
  final UserRole role;

  //? Fetches the list of courses for the current user based on their [role].
  ///
  /// Emits [HomeLoading] while fetching, and either [HomeSuccess] with the courses
  /// or [HomeFailure] with an error message.
  Future<void> fetchMyCourses({required UserRole role}) async {
     
     final cachedCourses = homeRepo.getCachedCourses();
     if (cachedCourses.isNotEmpty) {
      emit(HomeSuccess(cachedCourses)); 
    } else {
      emit(HomeLoading()); 
    }

    final result = await homeRepo.fetchMyCourses(role: role);

    result.fold(
      (failure) {
        if (state is HomeSuccess) {
          emitMessage(failure);
        } else {
          emit(HomeFailure(failure));
        }
      },
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

  //! removes a course unenroll as a student or delete as an instructor.
  ///
  /// Sends the course ID to the repository.
  /// If successful, re-fetches the user's courses and emits [RemoveCourseSuccess].
  Future<void> removeCourse({required String courseId}) async {
    emit(RemoveCourseLoading());

    final result = await homeRepo.removeCourse(courseId: courseId, role: role);

    result.fold(
      (errMessage) => emit(RemoveCourseFailure(errMessage)),
      (successMessage) {
        emit(RemoveCourseSuccess(successMessage));

        fetchMyCourses(role: role);
      },
    );
  }
}
