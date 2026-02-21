import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo, {required this.role}) : super(HomeInitial());

  final HomeRepo homeRepo;
  final UserRole role ;
  Future<void> fetchMyCourses({required UserRole role}) async {
    emit(HomeLoading());

    final result = await homeRepo.fetchMyCourses(role: role);

    result.fold(
      (failure) => emit(HomeFailure(failure)),
      (courses) => emit(HomeSuccess(courses)),
    );
  }

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
}
