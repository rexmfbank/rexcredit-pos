import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/_keyboard/keyboard_overlay.dart';
import 'package:rex_app/src/utils/amount_input_formatter.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class AppRexTextField extends StatefulWidget {
  const AppRexTextField(
      {super.key,
      required this.outerTitle,
      required this.controller,
      this.obscureText = false,
      this.focusNode,
      this.upArrowAction,
      this.downArrowAction,
      this.validator,
      this.onChanged,
      this.inputType,
      this.suffixIcon,
      this.prefixIcon,
      this.errorText,
      this.hintText,
      this.enabled,
      this.maxLength,
      this.hasInputFormat = false,
      this.backgroundColor,
      this.maxLines,
      this.minLines,
      this.readOnly = false,
      this.isRequired = true,
      this.onTap});

  final String outerTitle;
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final bool? enabled;
  final int? maxLength;
  final Color? backgroundColor;
  final bool hasInputFormat;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final bool? isRequired;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final VoidCallback? downArrowAction;
  final VoidCallback? upArrowAction;

  @override
  State<AppRexTextField> createState() => _AppRexTextFieldState();
}

class _AppRexTextFieldState extends State<AppRexTextField> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          if (Platform.isIOS) {
            KeyboardOverlay.showOverlay(context,
                keyboardUpButtonPressed: widget.upArrowAction,
                keyboardDownButtonPressed: widget.downArrowAction);
          }
        } else {
          if (Platform.isIOS) {
            KeyboardOverlay.removeOverlay();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.outerTitle),
        const SizedBox(height: 12),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.inputType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          readOnly: widget.readOnly!,
          onTap: widget.onTap,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
            widget.inputType == TextInputType.number && widget.hasInputFormat
                ? FilteringTextInputFormatter.digitsOnly
                : LengthLimitingTextInputFormatter(widget.maxLength),
            widget.inputType == TextInputType.number && widget.hasInputFormat
                ? AmountTextInputFormatter()
                : LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            fillColor: widget.backgroundColor ?? AppColors.rexWhite,
            filled: true,
            hintText: widget.hintText,
            errorText: widget.errorText,
            errorStyle: const TextStyle(color: AppColors.red),
            focusedBorder: AppConstants.rexInputBorder,
            enabledBorder: AppConstants.rexInputBorder,
            border: AppConstants.rexInputBorder,
            counterText: '',
          ),
        )
      ],
    );
  }
}
