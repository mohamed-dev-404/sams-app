import 'package:flutter/material.dart';
import 'package:sams_app/features/home/presentation/views/mixins/mixin_create_course.dart';
import 'package:sams_app/features/home/presentation/views/widgets/basic_information_section.dart';
import 'package:sams_app/features/home/presentation/views/widgets/create_course_button.dart';
import 'package:sams_app/features/home/presentation/views/widgets/grade_breakdown_section.dart';

class MobileCreateCourseViewBody extends StatefulWidget {
  const MobileCreateCourseViewBody({super.key});

  @override
  State<MobileCreateCourseViewBody> createState() =>
      _MobileCreateCourseViewBodyState();
}

class _MobileCreateCourseViewBodyState extends State<MobileCreateCourseViewBody>
    with CreateCourseLogic {
      
  @override
  void initState() {
    super.initState();
    initCourseLogic();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: BasicInformationSection(
                totalController: totalGradeController,
                finalController: finalExamController,
                courseNameController: courseNameController,
                courseCodeController: courseCodeController,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: GradeBreakdownSection(
                fields: classworkFields,
                remaining: remainingPoints,
                limit: totalClassworkLimit,
                onAddField: addDynamicField,
                onRemoveField: removeDynamicField,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: CreateCourseButton(formKey: formKey),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }
}
