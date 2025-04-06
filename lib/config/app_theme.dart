import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../gen/fonts.gen.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColor.transparent,
    fontFamily: FontFamily.poppins,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light().copyWith(
      primary: AppColor.darkPurple,
      secondary: AppColor.lightPurple,
      background: AppColor.background,
      onBackground: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: AppTextStyle.appBarText,
      iconTheme: const IconThemeData(color: AppColor.bluePrimary),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    textTheme:  const TextTheme(
      titleLarge: TextStyle(
        color: AppColor.titleColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.poppins,
      ),
      titleMedium: TextStyle(
        color: AppColor.subtitleColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
      ),
    ),
  );

  // Dark theme

  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColor.transparent,
    fontFamily: FontFamily.poppins,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark().copyWith(
      primary: AppColor.darkPurple,
      secondary: AppColor.lightPurple,
      background: AppColor.background,
      onBackground: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: AppTextStyle.appBarText,
      iconTheme: const IconThemeData(color: AppColor.bluePrimary),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColor.titleColorDark,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.poppins,
      ),
      titleMedium: TextStyle(
        color: AppColor.subtitleColorDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
      ),
    ),
  );
}
