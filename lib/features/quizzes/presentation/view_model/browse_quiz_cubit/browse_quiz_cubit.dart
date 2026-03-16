
import 'package:flutter_bloc/flutter_bloc.dart';

part 'browse_quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
}
