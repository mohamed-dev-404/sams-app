import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  AppStyles._();

  // =========================================================
  // 🔹 FONT FAMILY USED IN APP
  // =========================================================
  static const String _fontFamily = 'Poppins';

  // =========================================================
  // 🟣 MOBILE — TITLES
  // =========================================================

  /// Large Title
  static TextStyle mobileTitleLargeMd = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  /// Medium Title
  static TextStyle mobileTitleMediumSb = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileTitleMediumRg = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileTitleMediumLight = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w300,
    fontFamily: _fontFamily,
  );

  /// Small Title
  static TextStyle mobileTitleSmallSb = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  /// XSmall Title
  static TextStyle mobileTitleXsmallMd = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🔵 MOBILE — LABELS
  // =========================================================

  static TextStyle mobileLabelMediumMd = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileLabelMediumRg = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🟢 MOBILE — BUTTONS
  // =========================================================

  static TextStyle mobileButtonMediumSb = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🟡 MOBILE — BODY TEXT
  // =========================================================

  /// Small Body
  static TextStyle mobileBodySmallMd = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileBodySmallRg = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileBodySmallSb = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  /// Large Body
  static TextStyle mobileBodyLargeRg = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileBodyLargeSb = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileBodyLargeMd = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  /// Extra Sizes
  static TextStyle mobileBodyXlargeRg = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileBodyXXlargeMd = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  /// Medium Body
  static TextStyle mobileBodyMediumRg = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  /// XSmall Body
  static TextStyle mobileBodyXsmallRg = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle mobileBodyXsmallMd = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🔶 MOBILE — SPECIAL CASES
  // =========================================================

  static TextStyle mobile17Semibold = TextStyle(
    fontSize: 17.07.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — TITLES
  // =========================================================

  static TextStyle webTitleLargeMd = TextStyle(
    fontSize: 50.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle webTitleMediumSb = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle webTitleMediumMd = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — LABELS
  // =========================================================

  static TextStyle webLabelMd = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — BODY
  // =========================================================

  static TextStyle webBodySmallSb = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle webBodySmallRg = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — SPECIAL CASES
  // =========================================================

  static TextStyle web30Semibold = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle web32Semibold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle web30Regular = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle web36Light = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w300,
    fontFamily: _fontFamily,
  );

  static TextStyle web24Regular = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle web24Semibold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle web24Medium = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle web12Medium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle web14Regular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle web14Medium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle web15Regular = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle web16Medium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle web16Semibold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle web40Semibold = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle web20Regular = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle web10Regular = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  // AG Body
  static TextStyle webAgBodyBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
  );

  static TextStyle webAgBodyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );
}
