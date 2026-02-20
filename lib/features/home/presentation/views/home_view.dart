import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/views/layouts/mobile_home_view.dart';
import 'package:sams_app/features/home/presentation/views/layouts/web_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt.get<HomeRepo>())..fetchMyCourses(role: UserRole.teacher),
      child: AdaptiveLayout(
        mobileLayout: (context) => const MobileHomeView(),
        webLayout: (context) => const WebHomeView(),
      ),
    );
  }
}
