import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_android_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_cupertino_dropdown.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class CustomDropDownButton extends StatelessWidget {
  final ValueNotifier<String?> dropdownValue;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color dropIconColor;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? dropDownTextColor;
  final String? hintText;
  final bool withHint;
  final double? height;
  final double? borderWidth;
  final double? paddingWidth;
  final ValueNotifier<String?>? validationError;
  final VoidCallback? onTap;

  const CustomDropDownButton({
    super.key,
    required this.items,
    this.onChanged,
    required this.dropdownValue,
    this.hintText,
    this.dropIconColor = AppColors.rexTint500,
    this.backGroundColor,
    this.dropDownTextColor,
    this.borderColor,
    this.height,
    this.borderWidth,
    this.paddingWidth,
    this.textColor,
    this.hintStyle,
    this.style,
    this.onTap,
    this.withHint = true,
    this.validationError,
  }) : assert(!withHint || (withHint && hintText != null),
            'hint text shouldn\'t be null if withHint is true');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: validationError ?? ValueNotifier<String?>(null),
      builder: (__, String? error, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: error != null
                        ? AppColors.rexRedDark
                        : Colors.transparent,
                    width: 1),
              ),
              position: DecorationPosition.foreground,
              child: Platform.isIOS
                  ? RexCupertinoDropdown(
                      items: items,
                      hintText: hintText,
                      withHint: withHint,
                      hintStyle: hintStyle,
                      style: style,
                      dropdownValue: dropdownValue.value,
                      onChanged: onChanged,
                      dropIconColor: dropIconColor,
                      backgroundColor: backGroundColor,
                      borderColor: borderColor,
                      borderWidth: borderWidth,
                      textColor: textColor,
                      dropDownTextColor: dropDownTextColor,
                      height: height,
                      paddingWidth: paddingWidth,
                    )
                  : RexAndroidDropdown(
                      items: items,
                      hintText: hintText,
                      withHint: withHint,
                      hintStyle: hintStyle,
                      style: style,
                      dropdownValue: dropdownValue.value,
                      onChanged: onChanged,
                      dropIconColor: dropIconColor,
                      backgroundColor: backGroundColor,
                      borderColor: borderColor,
                      borderWidth: borderWidth,
                      textColor: textColor,
                      dropDownTextColor: dropDownTextColor,
                      height: height,
                      paddingWidth: paddingWidth,
                    ),
            ),
            if (error != null) const SizedBox(height: 8),
            if (error != null)
              Text(
                error,
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.rexRedDark,
                ),
              ),
          ],
        );
      },
    );
  }
}

class CustomBackgroundDropDownButton extends StatelessWidget {
  final String? dropdownValue;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final Color dropIconColor;
  final Color? textColor;
  final Color? dropDownTextColor;
  final String? hintText;
  final double? paddingWidth;
  final bool withHint;
  final ValueNotifier<String?>? validationError;
  final VoidCallback? onTap;

  const CustomBackgroundDropDownButton({
    super.key,
    required this.items,
    this.onChanged,
    required this.dropdownValue,
    this.hintText,
    this.dropIconColor = AppColors.rexTint500,
    this.withHint = true,
    this.validationError,
    this.textColor,
    this.onTap,
    this.paddingWidth,
    this.dropDownTextColor,
  }) : assert(withHint || hintText == null,
            'hint text shouldn\'t be null if withHint is true');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: ValueListenableBuilder(
        valueListenable: validationError ?? ValueNotifier<String?>(null),
        builder: (__, String? error, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  border: Border.all(
                      color: error != null
                          ? AppColors.rexRedDark
                          : Colors.transparent,
                      width: 1),
                ),
                position: DecorationPosition.foreground,
                child: Platform.isIOS
                    ? RexCupertinoDropdown(
                        items: items,
                        hintText: hintText,
                        withHint: withHint,
                        dropdownValue: dropdownValue,
                        onChanged: onChanged,
                        dropIconColor: dropIconColor,
                        backgroundColor: AppColors.rexWhite,
                        textColor: textColor,
                        paddingWidth: paddingWidth,
                        dropDownTextColor: dropDownTextColor,
                      )
                    : RexAndroidDropdown(
                        items: items,
                        hintText: hintText,
                        withHint: withHint,
                        dropdownValue: dropdownValue,
                        onChanged: onChanged,
                        dropIconColor: dropIconColor,
                        backgroundColor: AppColors.rexWhite,
                        textColor: textColor,
                        paddingWidth: paddingWidth,
                        dropDownTextColor: dropDownTextColor,
                      ),
              ),
              if (error != null) const SizedBox(height: 8),
              if (error != null)
                Text(
                  error,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.rexRedDark,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
