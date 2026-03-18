part of 'take_quiz_cubit.dart';

abstract class TakeQuizState extends Equatable {
  const TakeQuizState();

  @override
  List<Object?> get props => [];
}

class TakeQuizInitial extends TakeQuizState {}


class TakeQuizLoading extends TakeQuizState {}


class TakeQuizInProgress extends TakeQuizState {
  final int currentQuestionIndex;
  final int remainingSeconds;
  final int questionTimeLimit;
  final Map<String, String> selectedAnswers;
  final List<QuestionModel> questions;

  bool get isLast10Seconds => remainingSeconds <= 10 && remainingSeconds > 0;
  double get timeProgress => questionTimeLimit > 0 ? remainingSeconds / questionTimeLimit : 0.0;

  const TakeQuizInProgress({
    required this.currentQuestionIndex,
    required this.remainingSeconds,
    required this.questionTimeLimit,
    required this.selectedAnswers,
    required this.questions,
  });

  @override
  List<Object?> get props => [
        currentQuestionIndex,
        remainingSeconds,
        questionTimeLimit,
        selectedAnswers,
        questions,
      ];

  TakeQuizInProgress copyWith({
    int? currentQuestionIndex,
    int? remainingSeconds,
    int? questionTimeLimit,
    Map<String, String>? selectedAnswers,
    List<QuestionModel>? questions,
  }) {
    return TakeQuizInProgress(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      questionTimeLimit: questionTimeLimit ?? this.questionTimeLimit,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      questions: questions ?? this.questions,
    );
  }
}

class TakeQuizSuccess extends TakeQuizState {}

class TakeQuizFailure extends TakeQuizState {
  final String message;
  const TakeQuizFailure(this.message);

  @override
  List<Object?> get props => [message];
}
