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

  static TextStyle get mobileTitleLargeMd => TextStyle(
    fontSize: 32.sp.clamp(24, 40),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileTitleMediumSb => TextStyle(
    fontSize: 24.sp.clamp(18, 30),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileTitleMediumRg => TextStyle(
    fontSize: 24.sp.clamp(18, 30),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileTitleMediumLight => TextStyle(
    fontSize: 24.sp.clamp(18, 30),
    fontWeight: FontWeight.w300,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileTitleSmallSb => TextStyle(
    fontSize: 20.sp.clamp(16, 26),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileTitleXsmallMd => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🔵 MOBILE — LABELS
  // =========================================================

  static TextStyle get mobileLabelMediumMd => TextStyle(
    fontSize: 16.sp.clamp(14, 20),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileLabelMediumRg => TextStyle(
    fontSize: 16.sp.clamp(14, 20),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🟢 MOBILE — BUTTONS
  // =========================================================

  static TextStyle get mobileButtonMediumSb => TextStyle(
    fontSize: 22.sp.clamp(18, 28),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🟡 MOBILE — BODY TEXT
  // =========================================================

  static TextStyle get mobileBodySmallMd => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodySmallRg => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodySmallSb => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyLargeRg => TextStyle(
    fontSize: 18.sp.clamp(16, 24),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyLargeSb => TextStyle(
    fontSize: 18.sp.clamp(16, 24),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyLargeMd => TextStyle(
    fontSize: 18.sp.clamp(16, 24),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyXlargeRg => TextStyle(
    fontSize: 20.sp.clamp(16, 26),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyXXlargeMd => TextStyle(
    fontSize: 24.sp.clamp(20, 32),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyMediumRg => TextStyle(
    fontSize: 16.sp.clamp(14, 20),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyXsmallRg => TextStyle(
    fontSize: 12.sp.clamp(10, 16),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobileBodyXsmallMd => TextStyle(
    fontSize: 12.sp.clamp(10, 16),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get mobile17Semibold => TextStyle(
    fontSize: 17.07.sp.clamp(14, 22),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — TITLES
  // =========================================================

  static TextStyle get webTitleLargeMd => TextStyle(
    fontSize: 50.sp.clamp(35, 65),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get webTitleMediumSb => TextStyle(
    fontSize: 40.sp.clamp(28, 52),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get webTitleMediumMd => TextStyle(
    fontSize: 40.sp.clamp(28, 52),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — LABELS
  // =========================================================

  static TextStyle get webLabelMd => TextStyle(
    fontSize: 20.sp.clamp(16, 26),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — BODY
  // =========================================================

  static TextStyle get webBodySmallSb => TextStyle(
    fontSize: 20.sp.clamp(16, 26),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get webBodySmallRg => TextStyle(
    fontSize: 20.sp.clamp(16, 26),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  // =========================================================
  // 🌍 WEB — SPECIAL CASES
  // =========================================================

  static TextStyle get web30Semibold => TextStyle(
    fontSize: 30.sp.clamp(22, 38),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get web32Semibold => TextStyle(
    fontSize: 32.sp.clamp(24, 40),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get web30Regular => TextStyle(
    fontSize: 30.sp.clamp(22, 38),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get web36Light => TextStyle(
    fontSize: 36.sp.clamp(26, 46),
    fontWeight: FontWeight.w300,
    fontFamily: _fontFamily,
  );

  static TextStyle get web24Regular => TextStyle(
    fontSize: 24.sp.clamp(18, 30),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get web24Semibold => TextStyle(
    fontSize: 24.sp.clamp(18, 30),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get web24Medium => TextStyle(
    fontSize: 24.sp.clamp(18, 30),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get web12Medium => TextStyle(
    fontSize: 12.sp.clamp(10, 16),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get web14Regular => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get web14Medium => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get web15Regular => TextStyle(
    fontSize: 15.sp.clamp(13, 20),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get web16Medium => TextStyle(
    fontSize: 16.sp.clamp(14, 22),
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle get web16Semibold => TextStyle(
    fontSize: 16.sp.clamp(14, 22),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get web40Semibold => TextStyle(
    fontSize: 40.sp.clamp(30, 50),
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle get web20Regular => TextStyle(
    fontSize: 20.sp.clamp(16, 26),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get web10Regular => TextStyle(
    fontSize: 10.sp.clamp(8, 14),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle get webAgBodyBold => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
  );

  static TextStyle get webAgBodyRegular => TextStyle(
    fontSize: 14.sp.clamp(12, 18),
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );
}
