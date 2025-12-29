import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// utility class to define app fonts
class AppFont {
  AppFont._();

  static TextStyle normal = GoogleFonts.inter(fontWeight: FontWeight.normal);
  static TextStyle bold = GoogleFonts.inter(fontWeight: FontWeight.bold);
}

extension AppFontSize on TextStyle {
  TextStyle get s12 {
    return copyWith(fontSize: 12.sp);
  }

  TextStyle get s14 {
    return copyWith(fontSize: 14.sp);
  }

  TextStyle get s16 {
    return copyWith(fontSize: 16.sp);
  }

  TextStyle get s18 {
    return copyWith(fontSize: 18.sp);
  }

  TextStyle get s20 {
    return copyWith(fontSize: 20.sp);
  }
}
