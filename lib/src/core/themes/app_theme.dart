import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';
import 'app_font.dart';

/// utility class to define the app theme
class AppTheme {
  AppTheme._();

  static ThemeData data(bool isDark) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColor.black : AppColor.white,
        centerTitle: true,
        elevation: 2.h,
        titleTextStyle: AppFont.bold.s16.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      cardColor: Colors.white,
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   backgroundColor: isDark ? AppColor.orange : AppColor.orange,
      //   foregroundColor: isDark ? Colors.black:Colors.white ,
      //   elevation: 2.h,
      //   extendedTextStyle: AppFont.normal.s14,
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? AppColor.green : AppColor.green,
          elevation: 2.h,
          textStyle: AppFont.normal.s14.copyWith(
            color: isDark ? Colors.black:Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.openSans().fontFamily,
      textTheme: TextTheme(
        bodySmall: AppFont.normal.s12.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
        bodyMedium: AppFont.normal.s14.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
        bodyLarge: AppFont.normal.s16.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
       headlineLarge: AppFont.bold.s18.copyWith(
         color: isDark ? Colors.white : Colors.black,
       ),
        headlineMedium: AppFont.bold.s16.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
        headlineSmall: AppFont.bold.s12.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
        displayLarge: AppFont.bold.s20.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
        displayMedium: AppFont.bold.s14.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),

      ),
    );
  }
}
