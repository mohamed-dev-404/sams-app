import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/web/web_main_card.dart';
import 'package:sams_app/features/announcements/presentation/view_model/cubit/announcements_fetch/announcements_fetch_cubit.dart';
import 'package:sams_app/features/announcements/presentation/view_model/cubit/announcements_fetch/announcements_fetch_state.dart';

class AnnouncementsWebLayout extends StatelessWidget {
  const AnnouncementsWebLayout({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 12, 40, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'Announcements',
              style: AppStyles.webTitleMediumSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocBuilder<AnnouncementsFetchCubit, AnnouncementsFetchState>(
            /// [buildWhen] ensures the Grid doesn't disappear when the state shifts 
            /// to fetch individual announcement details. It preserves the list view.
            buildWhen: (previous, current) {
              return current is AnnouncementsFetchLoading || 
                     current is AnnouncementsFetchSuccess || 
                     current is AnnouncementsFetchFailure;
            },
            builder: (context, state) {
              if (state is AnnouncementsFetchLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              } 
              
              else if (state is AnnouncementsFetchSuccess) {
                final announcements = state.announcements;
                
                if (announcements.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('No announcements yet.')),
                  );
                }
                
                return SliverGrid.builder(
                  itemCount: announcements.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 350,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 220,
                    childAspectRatio: 301 / 240,
                  ),
                  itemBuilder: (context, index) {
                    return WebMainCard(
                      model: MainCardModel(
                        title: announcements[index].title,
                        description: announcements[index].content,
                        image: AppImages.imagesAnnouncementCard,
                        onTap: () {
                          /// Fetch specific details before navigating
                          context.read<AnnouncementsFetchCubit>().fetchAnnouncementDetails(
                            announcementId: announcements[index].id,
                          );

                          context.pushNamed(
                            RoutesName.announcementDetails,
                            pathParameters: {
                              'courseId': courseId,
                              'announcementId': announcements[index].id,
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              } 
              
              else if (state is AnnouncementsFetchFailure) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.errMessage)),
                );
              }
              
              /// Keep the list visible during details fetching thanks to [buildWhen]
              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
        ],
      ),
    );
  }
}