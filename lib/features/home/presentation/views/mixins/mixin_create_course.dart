
import 'package:flutter/material.dart';

mixin CreateCourseLogic<T extends StatefulWidget> on State<T> {
  final TextEditingController totalGradeController = TextEditingController();
  final TextEditingController finalExamController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> classworkFields = [];

  double remainingPoints = 0;
  double totalClassworkLimit = 0;

  
  void initCourseLogic() {
    totalGradeController.addListener(calculateGrades);
    finalExamController.addListener(calculateGrades);

    addDynamicField(label: 'Midterm');
    addDynamicField(label: 'Assignment');
    addDynamicField(label: 'Attendance');
    addDynamicField(label: 'Quiz 1');
    addDynamicField(label: 'Bonus');
  }

  void calculateGrades() {
    double total = double.tryParse(totalGradeController.text) ?? 0;
    double finalEx = double.tryParse(finalExamController.text) ?? 0;
    totalClassworkLimit = total - finalEx;

    double currentSum = 0;
    for (var field in classworkFields) {
      currentSum += double.tryParse(field['gradeController'].text) ?? 0;
    }

    setState(() {
      remainingPoints = totalClassworkLimit - currentSum;
    });
  }

  void addDynamicField({String label = ''}) {
    final nameController = TextEditingController(text: label);
    final gradeController = TextEditingController();
    gradeController.addListener(calculateGrades);

    setState(() {
      classworkFields.add({
        'nameController': nameController,
        'gradeController': gradeController,
      });
    });
  }

  void removeDynamicField(int index) {
    setState(() {
      classworkFields[index]['nameController'].dispose();
      classworkFields[index]['gradeController'].dispose();
      classworkFields.removeAt(index);
      calculateGrades();
    });
  }

  
  @override
  void dispose() {
    totalGradeController.dispose();
    finalExamController.dispose();
    for (var field in classworkFields) {
      field['nameController'].dispose();
      field['gradeController'].dispose();
    }
    super.dispose();
  }
}

