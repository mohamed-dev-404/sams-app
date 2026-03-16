import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';

part 'take_quiz_state.dart';

class TakeQuizCubit extends Cubit<TakeQuizState> {
  final QuizRepository _repository;

  TakeQuizCubit(this._repository) : super(TakeQuizInitial());

  // TODO: Implement Student interaction flow methods
}
