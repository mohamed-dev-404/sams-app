import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';
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
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) => current is CourseActionState,
      listener: (context, state) {
        if (state is CreateCourseSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.green,
            ),
          );
          Navigator.pop(context);
        } else if (state is CreateCourseFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
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
                  child: CreateCourseButton(
                    isLoading: state is CreateCourseLoading,
                    onPressed: () => submitCourse(context),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 60)),
              ],
            ),
          ),
        );
      },
    );
  }
}
