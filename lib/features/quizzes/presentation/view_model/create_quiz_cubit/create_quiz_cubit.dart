import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/classwork_item_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/data/model/request_bodies_models/create_quiz_request_body.dart';
import 'package:sams_app/features/quizzes/data/repos/quiz_repository.dart';
import 'package:sams_app/features/quizzes/presentation/view/create_quiz/model/create_quiz_form_args.dart';

part 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  final QuizRepository _repo;

  CreateQuizCubit(this._repo) : super(CreateQuizInitial()) {
    _initControllers();
  }

  // ── Form Elements ─────────────────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController durationController;
  late final TextEditingController startTimeDisplayController;

  // ── Data Variables ────────────────────────────────────────────────────────
  ClassworkItemModel? selectedClasswork;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  bool isEditMode = false;
  late String courseId;
  QuizModel? initialData;

  void _initControllers() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    durationController = TextEditingController();
    startTimeDisplayController = TextEditingController();
  }

  /// Initialises the form based on Create or Edit mode.
  void init(CreateQuizFormArgs args) {
    isEditMode = args.isEditMode;
    courseId = args.courseId;
    initialData = args.initialData;

    if (isEditMode && args.initialData != null) {
      titleController.text = initialData!.title;
      descriptionController.text = initialData!.description ?? '';
      final duration = initialData!.endTime
          .difference(initialData!.startTime)
          .inMinutes;
      durationController.text = duration.toString();

      _selectedDate = initialData!.startTime;
      _selectedTime = TimeOfDay.fromDateTime(initialData!.startTime);

      startTimeDisplayController.text = _formatDateTime(initialData!.startTime);
    }
    emit(CreateQuizUIUpdated());
  }

  // ── Input Actions ─────────────────────────────────────────────────────────

  /// Called when the user picks a classwork from the picker dialog.
  void onClassworkSelected(ClassworkItemModel item) {
    selectedClasswork = item;
    emit(CreateQuizUIUpdated());
  }

  void updateDate(DateTime date) {
    _selectedDate = date;
    _combineAndSyncDateTime();
  }

  void updateTime(TimeOfDay time) {
    _selectedTime = time;
    _combineAndSyncDateTime();
  }

  void _combineAndSyncDateTime() {
    if (_selectedDate != null && _selectedTime != null) {
      final combined = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      startTimeDisplayController.text = _formatDateTime(combined);
      emit(CreateQuizUIUpdated());
    }
  }

  String _formatDateTime(DateTime dt) =>
      DateFormat('MMM dd, yyyy - hh:mm a').format(dt);

  // ── Submit ────────────────────────────────────────────────────────────────
  Future<void> onSubmit() async {
    // 1. Validation
    if (isEditMode == false && selectedClasswork == null) {
      // ignore: prefer_const_constructors
      emit(CreateQuizFailure('Please select a classwork first.'));
      return;
    }

    if (!formKey.currentState!.validate()) return;

    if (_selectedDate == null || _selectedTime == null) {
      // ignore: prefer_const_constructors
      emit(CreateQuizFailure('Please select a start time.'));
      return;
    }

    // 2. Prepare Data
    final body = CreateQuizRequestBody(
      classworkId: isEditMode ? null : selectedClasswork?.id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      startTime: DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
      duration: int.tryParse(durationController.text.trim()),
    );

    // 3. Execution
    emit(CreateQuizLoading());

    final Either<String, void> result;
    try {
      if (isEditMode) {
        result = await _repo.updateQuiz(initialData!.id, body);
      } else {
        result = await _repo.createQuiz(courseId, body);
      }

      result.fold(
        (failureMessage) => emit(CreateQuizFailure(failureMessage)),
        (_) {
          final successMessage = isEditMode
              ? 'Quiz updated successfully'
              : 'Quiz created successfully';
          emit(CreateQuizSuccess(successMessage));
        },
      );
    } catch (e) {
      emit(CreateQuizFailure('Something went wrong: ${e.toString()}'));
    }
  }

  // ── Fetch Available Classworks ────────────────────────────────────────────
  /// Fetches the list of available classworks for [courseId].
  /// Emits [AvailableClassworksLoading] → [AvailableClassworksLoaded] or
  /// [AvailableClassworksFailure].
  Future<void> getAvailableClassworks() async {
    emit(AvailableClassworksLoading());

    final result = await _repo.getAvailableClassworks(courseId);
    result.fold(
      (failureMessage) => emit(AvailableClassworksFailure(failureMessage)),
      (classworks) => emit(AvailableClassworksLoaded(classworks)),
    );
  }

  // ── Add new classwork ──────────────────────────────────────────────────────
  /// Creates a new classwork for [courseId].
  /// On success, emits [CreateClassworkSuccess] then auto-refreshes
  /// the classwork list via [getAvailableClassworks].
  Future<void> addNewClasswork(String classworkName, num totalPoints) async {
    emit(CreateClassworkLoading());

    final result = await _repo.addNewClasswork(
      courseId,
      classworkName,
      totalPoints,
    );
    result.fold(
      (failureMessage) => emit(CreateClassworkFailure(failureMessage)),
      (successMessage) {
        emit(CreateClassworkSuccess(successMessage));
        // Auto-refresh so the new item appears in the picker list
        getAvailableClassworks();
      },
    );
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    startTimeDisplayController.dispose();
    return super.close();
  }
}
