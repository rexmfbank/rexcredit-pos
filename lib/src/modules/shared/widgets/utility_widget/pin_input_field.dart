import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class PinInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final double? height;
  final double? boxHeight;
  final double? width;
  final double? radius;
  final TextStyle? style;
  final Color? borderColor;
  final Color? fillColor;
  final Color? errorColor;
  final ValueChanged<String> onEditingComplete;
  final ValueNotifier<String?>? validationError;
  final VoidCallback? onTap;
  final VoidCallback onComplete;
  const PinInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.length,
    required this.onEditingComplete,
    required this.onComplete,
    this.height,
    this.boxHeight,
    this.width,
    this.radius,
    this.style,
    this.borderColor,
    this.fillColor,
    this.errorColor,
    this.validationError,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      margin: EdgeInsets.symmetric(horizontal: 5.aw),
      width: width ?? 65.aw,
      height: boxHeight ?? 65.ah,
      textStyle: style ??
          AppTextStyles.h4.copyWith(
            fontWeight: FontWeight.w500,
          ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius:
            BorderRadius.circular(AppConstants.size.lowerBoarderRadius),
        border: Border.all(
          color: AppColors.borderGrey,
          width: 0.5.ar,
        ),
      ),
    );

    return ValueListenableBuilder(
        valueListenable: validationError ?? ValueNotifier<String?>(null),
        builder: (BuildContext context, String? value, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height ?? 70.ah,
                child: Pinput(
                  length: length,
                  controller: controller,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  onChanged: (pin) {
                    onEditingComplete(pin);
                  },
                  onCompleted: (pin)=> onComplete.call(),
                  onTap: onTap,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    margin: EdgeInsets.symmetric(horizontal: 5.aw),
                    width: width ?? 65.aw,
                    height: boxHeight ?? 65.ah,
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(
                        color: borderColor ?? AppColors.rexPurpleLight,
                      ),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      color: errorColor ?? AppColors.rexRedDark,
                      borderRadius: BorderRadius.circular(
                          AppConstants.size.lowerBoarderRadius),
                    ),
                  ),
                ),
              ),
              value != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.ah),
                      child: Text(
                        value,
                        style: AppTextStyles.body1Regular.copyWith(
                          color: AppColors.rexRedDark,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        });
  }
}
