import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/web_coures_header_card.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/web/custom_web_tab_bar.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';

//! tab_bar_web_layout.dart
class TabBarWebLayout extends StatelessWidget {
  const TabBarWebLayout({
    super.key,
    required this.child,
    required this.courseId,
    required this.headerModel,
  });

  final Widget child;
  final String courseId;
  final CourseHeaderCardModel headerModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseNavigationCubit>();
    final currentPath = GoRouterState.of(context).uri.path;

    // Calculate which tab is active based on the URL
    final currentIndex = cubit.visibleTabs.indexWhere(
      (tab) => currentPath.contains(tab.path),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CustomWebTabBar(
              tabs: cubit.visibleTabs.map((e) => e.title).toList(),
              currentIndex: currentIndex == -1 ? 0 : currentIndex,
              onTap: (index) {
                final targetPath = cubit.visibleTabs[index].path;
                // Navigate and pass the headerModel to prevent it from turning null
                context.pushReplacement('/course/$courseId/$targetPath', extra: headerModel);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            WebCourseHeaderCard(cardModel: headerModel),
            const SizedBox(height: 20),
            Expanded(child: child), // Tab content changes here
          ],
        ),
      ),
    );
  }
}
