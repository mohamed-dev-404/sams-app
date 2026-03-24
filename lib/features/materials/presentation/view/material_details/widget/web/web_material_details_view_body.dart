import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/shared/tab_body_view.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/web/web_home_header.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/web/material_content_grid.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/web/material_details_side_card.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

class WebMaterialDetailsViewBody extends StatelessWidget {
  const WebMaterialDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
      // Only rebuild when the state is related to Material Details
      buildWhen: (previous, current) => current is MaterialDetailsState,
      builder: (context, state) {
        if (state is MaterialFetchLoading) {
          return const Center(child: AppAnimatedLoadingIndicator());
        }

        if (state is MaterialFetchFailure) {
          return Center(child: Text(state.errMessage));
        }

        if (state is MaterialFetchDetailsSuccess) {
          final material = state.material;

          return Column(
            children: [
              const WebHomeHeader(),
              Expanded(
                child: TabBodyView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      // Force SideCard and Content Column to have the same height
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. Sidebar info (Title, Description, Edit Button)
                        const Expanded(
                          flex: 2,
                          child: MaterialDetailsSideCard(),
                        ),

                        const SizedBox(width: 32), // Clear spacing for Web
                        // 2. Main content (Items Grid)
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  bottom: 20,
                                ),
                                child: Text(
                                  'Material Content',
                                  style: AppStyles.webTitleMediumSb.copyWith(
                                    color: AppColors.primaryDarkHover,
                                    fontSize:
                                        (MediaQuery.sizeOf(context).width *
                                                0.022)
                                            .clamp(24, 32),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: MaterialContentGrid(
                                  materials: material.materialItems,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
