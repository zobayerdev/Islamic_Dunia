import 'package:islamic_dunia/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFF071112, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF071112), //10%
      100: Color(0xFF071112), //20%
      200: Color(0xFF071112), //30%
      300: Color(0xFF071112), //40%
      400: Color(0xFF071112), //50%
      500: Color(0xFF071112), //60%
      600: Color(0xFF071112), //70%
      700: Color(0xFF071112), //80%
      800: Color(0xFF071112), //80%
      900: Color(0xFF071112), //80%
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primarySwatch: CustomTheme.kToDark,
      scaffoldBackgroundColor: AppColors.scaffoldColor,
    );
  }
}
