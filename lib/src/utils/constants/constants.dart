import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';

class AppConstants {
  static const size = _SizeConstant();

  static const designWidth = 375.0;
  static const designHeight = 812.0;

  static const pageIndex = 0;
  static const pageSize = 10;

  static double get deviceWidth {
    return ScreenUtil().screenWidth;
  }

  static double get deviceHeight {
    return ScreenUtil().screenHeight;
  }

  static EdgeInsets modalPadding = EdgeInsets.symmetric(
    vertical: 26.ah,
    horizontal: 18.aw,
  );

  static OutlineInputBorder rexInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.ar),
    borderSide: const BorderSide(color: AppColors.rexWhite),
  );
}

class _SizeConstant {
  const _SizeConstant();
  static const double _storyBarRadius = 22;
  static const double _toolBarHeight = 45;
  static const double _tileBorderRadius = 12;
  static const double _lowerBoarderRadius = 8;

  double get storyBarRadius => _storyBarRadius.ar;
  double get toolBarHeight => _toolBarHeight.ah;
  double get tileBorderRadius => _tileBorderRadius.ar;
  double get lowerBoarderRadius => _lowerBoarderRadius.ar;
}

extension SizeExtension on num {
  double get aw => w;
  double get ah => h;
  double get ar => r;
  double get asp => sp;
}
