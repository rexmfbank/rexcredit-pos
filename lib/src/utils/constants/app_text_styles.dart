import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

abstract class AppTextStyles {
  static TextStyle h1 = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.textBlack,
    fontSize: 25.asp,
  );

  static homeCardTheme(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: const Color(0xFF0E234A),
          );

  static TextStyle h2 = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
    fontSize: 14.asp,
  );

  static TextStyle h3 = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
    fontSize: 16.asp,
  );

  static TextStyle h4 = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
    fontSize: 20.asp,
  );

  static TextStyle h5 = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
    fontSize: 18.asp,
  );

  static TextStyle body1Regular = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textBlack,
    fontSize: 12.asp,
  );

  static TextStyle body2Regular = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textBlack,
    fontSize: 14.asp,
  );

  static TextStyle body3Regular = TextStyle(
    fontFamily: StringAssets.fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textBlack,
    fontSize: 10.asp,
  );

  static TextStyle bodyRegularSize14 = TextStyle(
    fontSize: 14.asp,
    fontWeight: FontWeight.w500,
    color: AppColors.rexPurpleDark,
  );

  static const walletText1 = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.rexPurpleDark,
    fontSize: 28,
  );

  static TextStyle titleSize18 = TextStyle(
    fontSize: 18.asp,
    fontWeight: FontWeight.w700,
    color: AppColors.rexPurpleDark,
  );

  static TextStyle titleSize14 = TextStyle(
    fontSize: 14.asp,
    fontWeight: FontWeight.w500,
    color: AppColors.rexTint500,
  );

  static TextStyle titleSize14Dark = TextStyle(
    fontSize: 14.asp,
    fontWeight: FontWeight.w500,
    color: AppColors.rexTint500,
  );

  static TextStyle h3b = h3.copyWith(fontWeight: FontWeight.w500);

  static TextStyle h2b = h2.copyWith(fontWeight: FontWeight.bold, fontSize: 16);

  static const placeholderNairaText = Text(
    "\u20A6....",
    style: walletText1,
  );

  static TextStyle transactionStatus = TextStyle(
    color: AppColors.rexPurpleDark,
    fontWeight: FontWeight.bold,
  );
}
