import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/cache/get_storage.dart';
import 'package:sams_app/core/utils/constants/cache_keys.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';

//* A widget that builds the active profile based on the current state of the profile cubit.
class ActiveProfileBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, String name, String? imagePath)
  builder;

  const ActiveProfileBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String name =
            GetStorageHelper.read<String>(CacheKeys.name) ?? 'UnKnown';
        String? imagePath = GetStorageHelper.read<String>(CacheKeys.profilePic);

        if (state is ProfileSuccess) {
          name = state.userModel.name!;
          imagePath = state.userModel.profilePic;
        }

        return builder(context, name, imagePath);
      },
    );
  }
}
