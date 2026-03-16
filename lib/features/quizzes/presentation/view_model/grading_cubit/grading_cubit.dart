import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';

part 'grading_state.dart';

class GradingCubit extends Cubit<GradingState> {
  final QuizRepository _repository;

  GradingCubit(this._repository) : super(GradingInitial());

  // TODO: Implement Instructor evaluation flow methods
}
