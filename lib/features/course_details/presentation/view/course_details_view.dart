import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/mobile/tab_bar_mobile_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/web/tab_bar_web_layout.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseNavigationCubit(),
      child: BlocBuilder<CourseNavigationCubit, int>(
        builder: (context, state) {
          final tabsCount = context.read<CourseNavigationCubit>().tabs.length;
          return DefaultTabController(
            length: tabsCount,
            initialIndex: state,
            child: Scaffold(
              body: AdaptiveLayout(
                mobileLayout: (context) =>
                    TabBarMobileLayout(navigationShell: navigationShell),
                webLayout: (context) =>
                    TabBarWebLayout(navigationShell: navigationShell),
              ),
            ),
          );
        },
      ),
    );
  }
}
