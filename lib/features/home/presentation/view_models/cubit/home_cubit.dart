import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/mixins/safe_emit_mixin.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';
import 'package:sams_app/core/utils/mixins/cubit_message_mixin.dart';

//* Manages home state — fetch, create, join, and remove courses
class HomeCubit extends Cubit<HomeState> with CubitMessageMixin, SafeEmitMixin {
  HomeCubit(this.homeRepo, {required this.role}) : super(HomeInitial());

  final HomeRepo homeRepo;
  final UserRole role;

  //* Load cached courses first, then fetch fresh data from API
  //* Shows cached data instantly while waiting for network response
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
          emitMessage(failure); // show error without clearing cached data
        } else {
          emit(HomeFailure(failure));
        }
      },
      (courses) => emit(HomeSuccess(courses)),
    );
  }

  //? POST new course → refresh courses list on success
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

  //? POST join course via invitation code → refresh courses list on success
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

  //! DELETE → unenroll (student) or delete (instructor) then refresh list
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
