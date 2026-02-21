import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/data/models/classwork_model.dart';
import 'package:sams_app/features/home/data/models/create_course_model.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';

mixin CreateCourseLogic<T extends StatefulWidget> on State<T> {
  // ! Controllers - Main form controllers
  final TextEditingController totalGradeController = TextEditingController();
  final TextEditingController finalExamController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ! Dynamic Fields - Holds nameController + gradeController
  final List<Map<String, dynamic>> classworkFields = [];

  double remainingPoints = 0;
  double totalClassworkLimit = 0;

  // ! Init - Attach listeners + add default fields
  void initCourseLogic() {
    totalGradeController.addListener(_recalculateGrades);
    finalExamController.addListener(_recalculateGrades);

    _addDefaultFields();
  }

  // ! Grade Calculation - Recalculate remaining points dynamically
  void _recalculateGrades() {
    final double total = double.tryParse(totalGradeController.text) ?? 0;
    final double finalExam = double.tryParse(finalExamController.text) ?? 0;

    totalClassworkLimit = total - finalExam;

    double currentSum = 0;
    for (var field in classworkFields) {
      currentSum += double.tryParse(field['gradeController'].text) ?? 0;
    }

    setState(() {
      remainingPoints = totalClassworkLimit - currentSum;
    });
  }

  // ! Add Field - Adds new classwork item
  void addDynamicField({String label = ''}) {
    final nameController = TextEditingController(text: label);
    final gradeController = TextEditingController()
      ..addListener(_recalculateGrades);

    setState(() {
      classworkFields.add({
        'nameController': nameController,
        'gradeController': gradeController,
      });
    });
  }

  // ! Remove Field - Dispose controllers before removing
  void removeDynamicField(int index) {
    final field = classworkFields[index];

    field['nameController'].dispose();
    field['gradeController'].dispose();

    setState(() {
      classworkFields.removeAt(index);
    });

    _recalculateGrades();
  }

  // ! Build Classwork List - Convert controllers to model list
  List<ClassworkModel> _buildClassworkList() {
    return classworkFields.map((field) {
      return ClassworkModel(
        name: field['nameController'].text.trim(),
        points: double.tryParse(field['gradeController'].text) ?? 0.0,
      );
    }).toList();
  }

  // ! Validation - Ensure grade distribution equals 100%
  bool _isGradeDistributionValid() {
    return remainingPoints.abs() <= 0.001;
  }

  // ! Submit Course - Validate → Build → Send to Cubit
  void submitCourse(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    if (!_isGradeDistributionValid()) {
      _showDistributionError(context);
      return;
    }

    final courseData = CreateCourseModel(
      name: courseNameController.text.trim(),
      academicCode: courseCodeController.text.trim(),
      totalGrades: double.parse(totalGradeController.text),
      finalExam: double.parse(finalExamController.text),
      classwork: _buildClassworkList(),
    );

    context.read<HomeCubit>().createCourse(course: courseData);
  }

  // ! Error Snackbar - Shows grade distribution error
  void _showDistributionError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          remainingPoints > 0
              ? 'Still have ${remainingPoints.toStringAsFixed(0)} points left!'
              : 'Exceeded by ${remainingPoints.abs().toStringAsFixed(0)} points!',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.whiteLight,
          ),
        ),
      ),
    );
  }

  // ! Dispose - Prevent memory leaks
  void disposeControllers() {
    totalGradeController.dispose();
    finalExamController.dispose();
    courseNameController.dispose();
    courseCodeController.dispose();

    for (var field in classworkFields) {
      field['nameController'].dispose();
      field['gradeController'].dispose();
    }

    super.dispose();
  }

  // ! Default Fields - Initial predefined classwork items
  void _addDefaultFields() {
    addDynamicField(label: 'Midterm');
    addDynamicField(label: 'Assignment');
    addDynamicField(label: 'Attendance');
    addDynamicField(label: 'Quiz 1');
    addDynamicField(label: 'Bonus');
  }
}
