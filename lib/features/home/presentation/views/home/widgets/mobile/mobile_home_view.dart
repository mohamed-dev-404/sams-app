import 'package:flutter/material.dart';
import 'package:sams_app/core/cache/get_storage.dart';
import 'package:sams_app/core/utils/constants/cache_keys.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/mobile/mobile_home_app_bar.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/mobile/mobile_home_view_body.dart';

//* The mobile layout for the home screen
class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final name = GetStorageHelper.read<String>(CacheKeys.name);
    final profilePicPath = GetStorageHelper.read<String>(CacheKeys.profilePic);

    return Scaffold(
      appBar: MobileHomeAppBar(
        userName: name ?? 'UnKnown',
        imagePath: profilePicPath,
      ),
      body: const MobileHomeViewBody(),
    );
  }
}
