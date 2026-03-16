import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';

part 'browse_quiz_state.dart';

class BrowseQuizCubit extends Cubit<BrowseQuizState> {
  final QuizRepository _repository;

  BrowseQuizCubit(this._repository) : super(QuizInitial());

  // TODO: Implement Discovery flow methods
}
