import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/classwork_item_model.dart';
import 'package:sams_app/features/quizzes/data/model/request_bodies_models/create_quiz_request_body.dart';

/// Mixin for handling Create Quiz form logic.
///
/// Mirrors the [CreateCourseLogic] pattern — keeps controllers, validation,
/// and request-body assembly in one reusable unit that any StatefulWidget
/// (mobile or web layout) can mix-in.
mixin CreateQuizLogic<T extends StatefulWidget> on State<T> {
  // ──────────────────── Form Key ────────────────────
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ──────────────────── Controllers ────────────────────
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController startTimeDisplayController =
      TextEditingController();

  // ──────────────────── State Variables ────────────────────
  ClassworItemkModel? selectedClasswork;
  DateTime? selectedStartTime;

  // ──────────────────── Mock Data ────────────────────
  /// Temporary mock list — will be replaced by API data via Cubit.
  final List<ClassworItemkModel> mockClassworkItems = const [
    ClassworItemkModel(
      id: '69bfb6e0236365ff8ee35687',
      name: 'Midterm',
      points: 15,
      isVisible: true,
    ),
    ClassworItemkModel(
      id: '69bfb6e0236365ff8ee3568a',
      name: 'Quiz 3',
      points: 5,
      isVisible: true,
    ),
    ClassworItemkModel(
      id: '69bfb6e0236365ff8ee3568b',
      name: 'Quiz 4',
      points: 5,
      isVisible: true,
    ),
  ];

  // ──────────────────── Classwork Selection ────────────────────

  void onClassworkSelected(ClassworItemkModel item) {
    setState(() {
      selectedClasswork = item;
    });
  }

  // ──────────────────── Date & Time Picker ────────────────────

  Future<void> pickStartDateTime(BuildContext context) async {
    // Step 1 — Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedStartTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null || !context.mounted) return;

    // Step 2 — Time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedStartTime != null
          ? TimeOfDay.fromDateTime(selectedStartTime!)
          : TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    // Combine
    final DateTime combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      selectedStartTime = combined;
      startTimeDisplayController.text =
          DateFormat('MMM dd, yyyy - hh:mm a').format(combined);
    });
  }

  // ──────────────────── Build Request Body ────────────────────

  CreateQuizRequestBody buildRequestBody() {
    return CreateQuizRequestBody(
      classworkId: selectedClasswork?.id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      startTime: selectedStartTime,
      duration: int.tryParse(durationController.text.trim()),
    );
  }

  // ──────────────────── Submit ────────────────────

  /// Validates the form and returns `true` if ready to submit.
  /// The actual API call will be wired through the Cubit later.
  bool validateAndPrepare() {
    if (!formKey.currentState!.validate()) return false;
    // Additional UI-level checks (optional — extend as needed)
    return true;
  }

  // ──────────────────── Dispose ────────────────────

  void disposeQuizControllers() {
    titleController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    startTimeDisplayController.dispose();
  }
}
