import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/shared/custom_course_card.dart';

//* Scrollable Sliver list for mobile home screen to display enrolled courses
class CourseSliverList extends StatefulWidget {
  const CourseSliverList({
    super.key,
  });

  @override
  State<CourseSliverList> createState() => _CourseSliverListState();
}

class _CourseSliverListState extends State<CourseSliverList> {
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    super.initState();
    //* Listen to global cubit messages (e.g., success/error alerts)
    _messageSubscription = context.read<HomeCubit>().messageStream.listen((
      msg,
    ) {
      if (mounted) {
        AppSnackBar.warning(context, msg);
      }
    });

    final role = context.read<HomeCubit>().role;
    context.read<HomeCubit>().fetchMyCourses(role: role);
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }

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
          //* Displays courses
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: CustomCourseCard(
                  course: state.courses[index],
                  role: CurrentRole.role,
                  isMobile: true,
                ),
              ),
              childCount: state.courses.length,
            ),
          );
        } else if (state is HomeFailure) {
          //! Fallback UI if data fetching fails
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
          //? Shows loading animation while waiting for data
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
