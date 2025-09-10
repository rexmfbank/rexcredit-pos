import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/_keyboard/keyboard_overlay.dart';
import 'package:rex_app/src/modules/shared/widgets/required_text.dart';
import 'package:rex_app/src/utils/amount_input_formatter.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexCustomTextField extends StatefulWidget {
  const RexCustomTextField({
    super.key,
    required this.outerTitle,
    this.hintText,
    this.controller,
    required this.obscureText,
    this.isRequired = true,
    this.suffixOuterTitle,
    this.focusNode,
    this.upArrowAction,
    this.downArrowAction,
    this.keyboardDoneAction,
    this.onTap,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.inputType,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.enabled,
    this.maxLength,
    this.hasInputFormat = false,
    this.backgroundColor,
    this.readOnly = false,
    this.initialValue,
  });

  final FocusNode? focusNode;
  final String outerTitle;
  final String? suffixOuterTitle;
  final void Function()? onTap;
  final String? hintText;
  final bool obscureText;
  final bool isRequired;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final bool? enabled;
  final int? maxLength;
  final Color? backgroundColor;
  final bool hasInputFormat;
  final bool readOnly;
  final String? initialValue;
  final VoidCallback? downArrowAction;
  final VoidCallback? upArrowAction;
  final VoidCallback? keyboardDoneAction;

  @override
  State<RexCustomTextField> createState() => _RexCustomTextFieldState();
}

class _RexCustomTextFieldState extends State<RexCustomTextField> {
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
            KeyboardOverlay.showOverlay(
              context,
              keyboardUpButtonPressed: widget.upArrowAction,
              keyboardDownButtonPressed: widget.downArrowAction,
              keyboardDoneButtonPressed: widget.keyboardDoneAction,
            );
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.ah, horizontal: 16.aw),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.onTap != null
                  ? GestureDetector(
                      onTap: widget.onTap,
                      child: RequiredText(
                        title: widget.outerTitle,
                        isRequired: widget.isRequired,
                      ),
                    )
                  : Text(
                      widget.outerTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onTap: widget.onTap,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.inputType,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            textCapitalization: TextCapitalization.words,
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
              focusedBorder: rexInputBorder,
              enabledBorder: rexInputBorder,
              border: rexInputBorder,
            ),
          )
        ],
      ),
    );
  }
}

/// OutlineInputBorder for the default texfield in the Rex App.
final rexInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(
    color: AppColors.rexWhite,
  ),
);
