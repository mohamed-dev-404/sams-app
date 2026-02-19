import 'package:flutter/material.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/web_profile_body.dart';

class WebProfileView extends StatelessWidget {
  const WebProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebProfileViewBody(),
    );
  }
}
