import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/mobile/tab_bar_mobile_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/web/tab_bar_web_layout.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_course_card.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({
    super.key,
    required this.navigationShell,
    required this.headerModel,
  });

  final StatefulNavigationShell navigationShell;
  final CourseHeaderCardModel headerModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseNavigationCubit(userRole: UserRole.student),
      child: Builder(
        builder: (context) {
          final cubit = context.read<CourseNavigationCubit>();

          return DefaultTabController(
            key: ValueKey(navigationShell.currentIndex),
            length: cubit.tabs.length,
            initialIndex: navigationShell.currentIndex,
            child: Scaffold(
              body: AdaptiveLayout(
                mobileLayout: (context) => TabBarMobileLayout(
                  navigationShell: navigationShell,
                  //  headerModel: headerModel,
                ),
                webLayout: (context) => TabBarWebLayout(
                  navigationShell: navigationShell,
                  headerModel: headerModel,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
