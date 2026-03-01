import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/mobile/tab_bar_mobile_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/web/tab_bar_web_layout.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_course_card.dart';

class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView({
    super.key,
    required this.navigationShell,
    required this.headerModel,
    required this.courseId,
  });

  final String courseId;
  final StatefulNavigationShell navigationShell;
  final CourseHeaderCardModel headerModel;

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  @override
  void initState() {
    super.initState();
    if (widget.headerModel == null) {
      print('Fetching data for course: ${widget.courseId}');
      // callYourApi(widget.courseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseNavigationCubit(userRole: UserRole.student),
      child: Builder(
        builder: (context) {
          final cubit = context.read<CourseNavigationCubit>();

          final currentUiIndex = cubit.getUiIndexFromBranch(
            widget.navigationShell.currentIndex,
          );

          return DefaultTabController(
            key: ValueKey(
              '${widget.courseId}_${widget.navigationShell.currentIndex}',
            ),
            length: cubit.visibleTabs.length,
            initialIndex: currentUiIndex,
            child: AdaptiveLayout(
              mobileLayout: (context) => TabBarMobileLayout(
                navigationShell: widget.navigationShell,
                headerModel: widget.headerModel,
                courseId: widget.courseId,
              ),
              webLayout: (context) => TabBarWebLayout(
                navigationShell: widget.navigationShell,
                courseId: widget.courseId,
                headerModel: widget.headerModel,
              ),
            ),
          );
        },
      ),
    );
  }
}
