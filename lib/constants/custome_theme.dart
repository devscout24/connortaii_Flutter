import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFFF9500A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: AppColors.cFFFFFF, //10%
      100: AppColors.cFFFFFF, //20%
      200: AppColors.cFFFFFF, //30%
      300: AppColors.cFFFFFF, //40%
      400: AppColors.cFFFFFF, //50%
      500: AppColors.cFFFFFF, //60%
      600: AppColors.cFFFFFF, //70%
      700: AppColors.cFFFFFF, //80%
      800: AppColors.cFFFFFF, //80%
      900: AppColors.cFFFFFF, //80%
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primarySwatch: CustomTheme.kToDark,
      scaffoldBackgroundColor: AppColors.cFFFFFF,
    );
  }
}
