import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/presentation/views/mixins/mixin_create_course.dart';
import 'package:sams_app/features/home/presentation/views/widgets/basic_information_section.dart';
import 'package:sams_app/features/home/presentation/views/widgets/create_course_button.dart';
import 'package:sams_app/features/home/presentation/views/widgets/grade_breakdown_section.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_header.dart';

class WebCreateCourseViewBody extends StatefulWidget {
  const WebCreateCourseViewBody({super.key});

  @override
  State<WebCreateCourseViewBody> createState() =>
      _WebCreateCourseViewBodyState();
}

class _WebCreateCourseViewBodyState extends State<WebCreateCourseViewBody>
    with CreateCourseLogic {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: WebHomeHeader(),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text('Create Course', style: AppStyles.webTitleMediumMd),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        // Forms Side by Side
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: BasicInformationSection(
                      totalController: totalGradeController,
                      finalController: finalExamController,
                      courseNameController: courseNameController,
                      courseCodeController: courseCodeController,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GradeBreakdownSection(
                      fields: classworkFields,
                      remaining: remainingPoints,
                      limit: totalClassworkLimit,
                      onAddField: addDynamicField,
                      onRemoveField: removeDynamicField,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 40)),
        SliverToBoxAdapter(child: CreateCourseButton(formKey: formKey)),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }
}
