import 'package:dico/app/utils/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Vazir',
    splashFactory: const InkResponse().splashFactory,
  );
  static final ThemeData darkTheme = ThemeData.dark();
}
