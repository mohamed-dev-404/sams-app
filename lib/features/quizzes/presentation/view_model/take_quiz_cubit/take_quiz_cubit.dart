import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/question_model.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';

part 'take_quiz_state.dart';

class TakeQuizCubit extends Cubit<TakeQuizState> {
  final QuizRepository _repository;
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _hasPlayedAlert = false;

  TakeQuizCubit(this._repository) : super(TakeQuizInitial());


// TODO: call a method to fetch the data first
Future<void> fetchQuestionsAndStart(String quizId) async {
  // 1. Tell UI to show a spinner
  emit(TakeQuizLoading()); 
  
  // 2. Hit the API via your Repository!
  final result = await _repository.getQuizQuestions(quizId);
  
  // result.fold(
  //   (failure) {
  //     // 3a. If Server error -> Tell UI to show error message
  //     emit(TakeQuizFailure(failure.message));
  //   },
  //   (questionsList) {
  //     // 3b. If Success -> Hand the real data over to your existing Timer flow!
  //     startQuiz(questionsList);
  //   }
  // );
}

  void startQuiz(List<QuestionModel> questions) {
    if (questions.isEmpty) return;

    _timer?.cancel();
    _audioPlayer.stop();
    _hasPlayedAlert = false;

    emit(
      TakeQuizInProgress(
        currentQuestionIndex: 0,
        remainingSeconds: questions[0].timeLimit,
        questionTimeLimit: questions[0].timeLimit,
        selectedAnswers: const {},
        questions: questions,
      ),
    );
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state is! TakeQuizInProgress) {
        timer.cancel();
        return;
      }

      final currentState = state as TakeQuizInProgress;
      if (currentState.remainingSeconds > 0) {
        final newTime = currentState.remainingSeconds - 1;

        // Play audio exactly when hitting 10 seconds
        if (newTime == 10 && !_hasPlayedAlert) {
          _hasPlayedAlert = true;
          _playAlertSound();
        }

        emit(currentState.copyWith(remainingSeconds: newTime));
      } else {
        timer.cancel();
        _autoGoToNextQuestion();
      }
    });
  }

  Future<void> _playAlertSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/time-alert.mp3'));
    } catch (e) {
      // Ignored: MissingPluginException happens on hot restart or web without proper reload
    }
  }

  void _autoGoToNextQuestion() {
    final currentState = state as TakeQuizInProgress;
    if (currentState.currentQuestionIndex < currentState.questions.length - 1) {
      goToNextQuestion();
    } else {
      submitQuiz();
    }
  }

  void goToNextQuestion() {
    if (state is TakeQuizInProgress) {
      final currentState = state as TakeQuizInProgress;
      if (currentState.currentQuestionIndex <
          currentState.questions.length - 1) {
        _moveToQuestion(currentState.currentQuestionIndex + 1, currentState);
      }
    }
  }

  void goToPreviousQuestion() {
    if (state is TakeQuizInProgress) {
      final currentState = state as TakeQuizInProgress;
      if (currentState.currentQuestionIndex > 0) {
        _moveToQuestion(currentState.currentQuestionIndex - 1, currentState);
      }
    }
  }

  void _moveToQuestion(int index, TakeQuizInProgress currentState) {
    _timer?.cancel();
    _audioPlayer.stop();
    _hasPlayedAlert = false;

    final timeLimit = currentState.questions[index].timeLimit;

    emit(
      currentState.copyWith(
        currentQuestionIndex: index,
        remainingSeconds: timeLimit,
        questionTimeLimit: timeLimit,
      ),
    );

    _startTimer();
  }

  void saveAnswer(String questionId, String answerId) {
    if (state is TakeQuizInProgress) {
      final currentState = state as TakeQuizInProgress;
      final newAnswers = Map<String, String>.from(
        currentState.selectedAnswers,
      ); // why we do this?
      // because the map is immutable, so we need to create a new map with the new answer
      // what is mean by .from ?
      // it is a constructor that creates a new map from the given map
      newAnswers[questionId] = answerId;
      emit(currentState.copyWith(selectedAnswers: newAnswers));
    }
  }

  void submitQuiz() {
    _timer?.cancel();
    _audioPlayer.stop();
    emit(TakeQuizSuccess());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}
