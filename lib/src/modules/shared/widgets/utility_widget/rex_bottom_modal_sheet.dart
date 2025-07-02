import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

Future<bool?> showPlatformBottomSheet({
  required BuildContext context,
  required Widget child,
  Widget? content,
  Color? backgroundColor,
  Color? barrierColor,
  ShapeBorder? shapeBorder,
  double? borderRadius,
  double? elevation,
  BoxShadow? boxShadow,
  isDismissible = true,
  enableDrag = true,
  useSafeArea = false,
  BoxConstraints? constraints,
  MainAxisAlignment? actionAlignment = MainAxisAlignment.end,
}) async {
  if (Platform.isIOS) {
    return showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor ?? AppColors.rexWhite,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      elevation: elevation,
      shadow: boxShadow,
      enableDrag: enableDrag,
      shape: shapeBorder ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius ?? 30.ar),
              topRight: Radius.circular(borderRadius ?? 30.ar),
            ),
          ),
      builder: (context) {
        return Material(
          child: child,
        );
      },
    );
  } else {
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor ?? AppColors.rexWhite,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      elevation: elevation,
      enableDrag: enableDrag,
      shape: shapeBorder ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius ?? 30.ar),
              topRight: Radius.circular(borderRadius ?? 30.ar),
            ),
          ),
      builder: (context) {
        return child;
      },
    );
  }
}
