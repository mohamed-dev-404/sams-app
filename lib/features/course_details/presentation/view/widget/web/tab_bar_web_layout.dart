import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/web_coures_header_card.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/course_tabs_content.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/web/custom_web_tab_bar.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';

//! tab_bar_web_layout.dart
class TabBarWebLayout extends StatelessWidget {
  const TabBarWebLayout({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseNavigationCubit>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CustomWebTabBar(
              tabs: cubit.tabs,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            WebCourseHeaderCard(
              cardModel: CourseHeaderCardModel(
                description:
                    'Stay informed about important campus news, academic updates, events, and opportunities so you never miss what matters.',
                title: 'Database',
                instructor: 'Julie Watson',
              ),
            ),
            Expanded(
              child: TabBarView(
                children: getCourseTabsContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
