// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/styles/app_styles.dart';

// class CustomPinputField extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(bool isValid) onValidationChanged; // Callback for button state

//   const CustomPinputField({
//     super.key,
//     required this.controller,
//     required this.onValidationChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 103.sp,
//       height: 104.sp,

//       textStyle: AppStyles.web40Semibold.copyWith(
//         fontWeight: FontWeight.w800,
//         color: AppColors.greenActive,
//       ),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: AppColors.greenActive,
//           width: 1,
//         ),
//       ),
//     );
//     final focusedPinTheme = defaultPinTheme.copyWith(
//       width: 117.sp,
//       height: 118.sp,
//       decoration: defaultPinTheme.decoration!.copyWith(
//         border: Border.all(
//           color: AppColors.greenActive,
//           width: 3,
//         ), //
//       ),
//     );

//     return Container(
//       color: Colors.amber,
//       height: 117,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // mainAxisSize: MainAxisSize.min,
//         children: [
//           Pinput(
//             length: 6,
//             controller: controller,
//             autofocus: true,
//             showCursor: true,
//             cursor: _buildCustomCursor(),
//             defaultPinTheme: defaultPinTheme,
//             focusedPinTheme: focusedPinTheme,
//             animationDuration: const Duration(milliseconds: 350),
//             pinAnimationType: PinAnimationType.scale,
//             keyboardType: TextInputType.number,
//             // Only notify the parent when the state changes
//             onChanged: (value) {
//               onValidationChanged(value.length == 6);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCustomCursor() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 2, // Thin cursor
//           height: 40, // Match your font size
//           color: AppColors.greenActive,
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class CustomPinputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(bool isValid) onValidationChanged;

  const CustomPinputField({
    super.key,
    required this.controller,
    required this.onValidationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate dynamic size based on available width
        // (Max Width - Total Horizontal Spacing) / Number of Pins
        // This ensures it never overflows
        double dynamicWidth = (constraints.maxWidth - 80) / 6;

        // Clamp: Min 50px (so it stays readable), Max 103px (Figma spec)
        double finalSize = dynamicWidth.clamp(50.0, 103.0);

        final defaultTheme = PinTheme(
          width: finalSize,
          height: finalSize, // Matches Figma's 103x103
          textStyle: AppStyles.web40Semibold.copyWith(
            fontSize: (finalSize * 0.4), // Scale text size with the circle
            fontWeight: FontWeight.w800,
            color: AppColors.primaryDark,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.greenActive,
              width: 1,
            ),
          ),
        );

        final focusedTheme = defaultTheme.copyWith(
          // Scale slightly on focus
          width: finalSize + 15,
          height: finalSize + 15,
          decoration: defaultTheme.decoration!.copyWith(
            border: Border.all(
              color: AppColors.greenActive,
              width: 4, // Thicker border on focus
            ),
          ),
        );

        return SizedBox(
          width: constraints.maxWidth,
          height: finalSize + 9,
          child: Pinput(
            length: 6,
            controller: controller,
            autofocus: true,
            showCursor: true,
            keyboardType: TextInputType.number,
            // SpaceBetween prevents the "Shifting" by anchoring to edges
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            defaultPinTheme: defaultTheme,
            focusedPinTheme: focusedTheme,
            animationDuration: const Duration(milliseconds: 350),
            pinAnimationType: PinAnimationType.scale,
            onChanged: (value) {
              onValidationChanged(value.length == 6);
            },
            cursor: _buildCustomCursor(context),
          ),
        );
      },
    );
  }

  Widget _buildCustomCursor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.isMobile(context)
              ? 7.w.clamp(5, 15)
              : 30.w.clamp(15, 30),
          height: 2.h,
          color: AppColors.primaryDark,
        ),
      ],
    );
  }
}
