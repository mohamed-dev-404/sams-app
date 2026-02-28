import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';
import 'package:sams_app/features/home/presentation/views/widgets/custom_course_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_course_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_new_course_card.dart';

class CoursesSliverGrid extends StatelessWidget {
  const CoursesSliverGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == state.courses.length - 1) {
                    return const WebNewCourseCard(
                      role: UserRole.student,
                    );
                  }
                  return CustomCourseCard(
                    course: state.courses[index],
                    role: UserRole.student,
                    isMobile: false,
                  );
                  // WebCourseCard(
                  //   course: state.courses[index],
                  //   role: UserRole.student,
                  // );
                },
                childCount: state.courses.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 301 / 240,
              ),
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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: AppAnimatedLoadingIndicator()),
            ),
          );
        }
      },
    );
  }
}
