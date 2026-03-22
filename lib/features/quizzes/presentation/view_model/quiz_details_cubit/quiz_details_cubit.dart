import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/quiz_details_cubit/quiz_details_state.dart';

class QuizDetailsCubit extends Cubit<QuizDetailsState> {
  final QuizRepository _quizRepo;

  QuizDetailsCubit(this._quizRepo) : super(QuizDetailsInitial());

  Future<void> getQuizDetails(String quizId) async {
    emit(QuizDetailsLoading());

    final result = await _quizRepo.getQuizDetails(quizId);

    result.fold(
      (error) => emit(QuizDetailsFailure(errorMessage: error)),
      (quiz) => emit(
        QuizDetailsSuccess(
          quiz: quiz,
        ),
      ),
    );
  }
}
