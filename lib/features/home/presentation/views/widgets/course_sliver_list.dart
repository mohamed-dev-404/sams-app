import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';
import 'package:sams_app/features/home/presentation/views/widgets/custom_course_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/mobile_course_card.dart';

class CourseSliverList extends StatelessWidget {
  const CourseSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is HomeSuccess ||
            current is HomeFailure ||
            current is HomeLoading;
      },
      builder: (context, state) {
        if (state is HomeSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: CustomCourseCard(course: state.courses[index], role: UserRole.student, isMobile: true)
                // MobileCourseCard(
                //   role: UserRole.student,
                //   courseModel: state.courses[index],
                // ),
              ),
              childCount: state.courses.length,
            ),
          );
        } else if (state is HomeFailure) {
          return SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUJoseKWLdz4o3GA4o_7P-b0cVClLE5o1RM0skmuTHYQ&s',
                ),
                const SizedBox(height: 10),
                Text(state.errMessage),
              ],
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: AppAnimatedLoadingIndicator())),
          );
        }
      },
    );
  }
}
