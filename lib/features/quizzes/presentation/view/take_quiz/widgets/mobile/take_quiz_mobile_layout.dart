import 'package:flutter/material.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/presentation/view/take_quiz/widgets/shared/quiz_question_card.dart';

class TakeQuizMobileLayout extends StatefulWidget {
  const TakeQuizMobileLayout({super.key});

  @override
  State<TakeQuizMobileLayout> createState() => _SubmitQuizViewState();
}

class _SubmitQuizViewState extends State<TakeQuizMobileLayout> {
  int currentIndex = 0;

  // This map acts as your mock Cubit state to store answers by Question ID
  final Map<String, String> mockSelectedAnswers = {};

  void _goToNextQuestion() {
    if (currentIndex < mockQuestions.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void _goToPreviousQuestion() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = mockQuestions[currentIndex];

    // Retrieve the answer for the current question if it exists in our mock state
    final savedAnswer = mockSelectedAnswers[currentQuestion.id];

    return Scaffold(
      // Temporary Navigation Controls for testing
      floatingActionButton: FloatingActionButton(
        onPressed: currentIndex < mockQuestions.length - 1
            ? _goToNextQuestion
            : null,
        child: const Icon(Icons.arrow_forward_outlined),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              // The component we built
              QuizQuestionCard(
                questionIndex: currentIndex + 1,
                question: currentQuestion,
                // Pass the saved answer (works for both choice ID and written text)
                selectedAnswerId: savedAnswer,
                writtenAnswer: savedAnswer,
                onAnswerSelected: (answer) {
                  // Mocking the Cubit's saveAnswer method
                  setState(() {
                    mockSelectedAnswers[currentQuestion.id] = answer;
                  });
                },
              ),
              const Spacer(),
              //! Temporary Navigation Controls for testing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: currentIndex > 0 ? _goToPreviousQuestion : null,
                    child: const Text('Previous'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
