import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/general_arrow_back.dart';

class MobileCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MobileCustomAppBar({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.arrowBackColor,
  });
  final String title;
  final TextStyle titleStyle;
  final Color arrowBackColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(title, style: titleStyle),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: GeneralArrowBack(color: arrowBackColor),
      ),
    );
  }
}
