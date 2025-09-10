import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const rexSliderTheme = SliderThemeData(
  showValueIndicator: ShowValueIndicator.always,
);

const globalAppBarTheme = AppBarTheme(
  elevation: 0.0,
  // foregroundColor: Color(0xff130F26),
  // backgroundColor: Color(0xffECECEC),
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ),
);
