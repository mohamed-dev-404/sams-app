import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';

part 'manage_quiz_state.dart';

class ManageQuizCubit extends Cubit<ManageQuizState> {
  final QuizRepository _repository;

  ManageQuizCubit(this._repository) : super(ManageQuizInitial());

  // TODO: Implement Instructor CRUD flow methods
}
