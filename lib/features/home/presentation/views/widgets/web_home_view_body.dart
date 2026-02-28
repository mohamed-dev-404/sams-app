import 'package:flutter/widgets.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/web_course_header_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/courses_sliver_grid.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_header.dart';

class WebHomeViewBody extends StatelessWidget {
  const WebHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // 🟢 Header
        const SliverToBoxAdapter(
          child: WebHomeHeader(),
        ),

        // 🟢 Course Header Card
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          sliver: SliverToBoxAdapter(
            child: WebCourseHeaderCard(
              cardModel: CourseHeaderCardModel(
                description:
                    'Stay informed about important campus news, academic updates, events, and opportunities so you never miss what matters new mmmmmmmshtsftf.',
                title: 'Courses',
              ),
            ),
          ),
        ),

        // 🟢 Title: My Courses
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          sliver: SliverToBoxAdapter(
            child: Text(
              'My Courses',
              style: AppStyles.webTitleMediumSb,

              // AppStylesSecondary.webTitleMediumSb(context),
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),

        // 🟢 Grid Courses
        const CoursesSliverGrid(),
      ],
    );
  }
}

