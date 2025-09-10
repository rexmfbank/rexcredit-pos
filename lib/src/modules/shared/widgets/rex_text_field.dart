import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/_keyboard/keyboard_overlay.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class RexTextField extends StatefulWidget {
  const RexTextField({
    super.key,
    this.focusNode,
    this.outerTitle,
    this.autoFocus = false,
    this.outerTitleFontSize,
    this.hintText,
    this.initialValue,
    this.controller,
    this.obscureText = false,
    this.suffixOuterTitle,
    this.onTapSuffixOuterTitle,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.inputType,
    this.textInputAction,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.enabled,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.hasInputFormat = false,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.showOuterTile = false,
    this.horizontalPadding,
    this.verticalPadding,
    this.expand = false,
    this.readOnly = false,
    this.showCursor,
    this.height,
    this.width,
    this.inputFormatter,
    this.keyboardUpArrowAction,
    this.keyboardDownArrowAction,
    this.keyboardDoneAction,
    this.onTap,
    this.hintStyle,
    this.style,
    this.textFieldIsRequired = false,
    this.enabledStyle,
    this.enableSuggestions,
    this.autofillHints,
    this.autocorrect,
  });

  final FocusNode? focusNode;
  final String? outerTitle;
  final double? outerTitleFontSize;
  final String? suffixOuterTitle;
  final void Function()? onTapSuffixOuterTitle;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? errorText;
  final bool? enabled;
  final bool autoFocus;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final Color? backgroundColor;
  final bool hasInputFormat;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? borderRadius;
  final double? height;
  final double? width;
  final Color? borderColor;
  final bool showOuterTile;
  final bool expand;
  final bool readOnly;
  final bool? showCursor;
  final List<TextInputFormatter>? inputFormatter;
  final bool textFieldIsRequired;
  final VoidCallback? keyboardDownArrowAction;
  final VoidCallback? keyboardUpArrowAction;
  final VoidCallback? keyboardDoneAction;
  final VoidCallback? onTap;
  final TextStyle? enabledStyle;
  final bool? enableSuggestions;
  final Iterable<String>? autofillHints;
  final bool? autocorrect;

  @override
  State<RexTextField> createState() => _RexTextFieldState();
}

class _RexTextFieldState extends State<RexTextField> {
  /// OutlineInputBorder for the default texfield in the Rex App.
  late final OutlineInputBorder inputBorder;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 14.ar),
      borderSide: BorderSide(color: widget.borderColor ?? AppColors.rexWhite),
    );
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (Platform.isIOS) {
          KeyboardOverlay.removeOverlay();
          // KeyboardOverlay.showOverlay(
          //   context,
          //   keyboardUpButtonPressed: widget.keyboardUpArrowAction,
          //   keyboardDownButtonPressed: widget.keyboardDownArrowAction,
          //   keyboardDoneButtonPressed: widget.keyboardDoneAction,
          // );
        }
      } else {
        if (Platform.isIOS) {
          KeyboardOverlay.removeOverlay();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: widget.verticalPadding ?? 8.ah,
        horizontal: widget.horizontalPadding ?? 16.aw,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showOuterTile && widget.outerTitle.isNotBlank) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child:
                      widget.textFieldIsRequired
                          ? RexTextFieldRichText(
                            title1: widget.outerTitle!,
                            color1: AppColors.rexPurpleDark,
                          )
                          : Text(
                            widget.outerTitle!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: widget.outerTitleFontSize ?? 15.asp,
                              color: AppColors.rexPurpleDark,
                            ),
                          ),
                ),
                widget.onTapSuffixOuterTitle != null
                    ? TextButton(
                      onPressed: widget.onTapSuffixOuterTitle,
                      child: Text(widget.suffixOuterTitle ?? ''),
                    )
                    : Container(),
              ],
            ),
            SizedBox(height: 12.ah),
          ],
          SizedBox(
            height: widget.height,
            width: widget.width,
            child: TextFormField(
              autocorrect: widget.autocorrect ?? true,
              enableSuggestions: widget.enableSuggestions ?? true,
              autofillHints: widget.autofillHints,
              onTap: widget.onTap,
              focusNode: focusNode,
              showCursor: widget.showCursor,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              controller: widget.controller,
              validator: widget.validator,
              onChanged: widget.onChanged,
              autofocus: widget.autoFocus,
              onEditingComplete: widget.onEditingComplete,
              initialValue: widget.initialValue,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: widget.inputType,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              expands: widget.expand,
              readOnly: widget.readOnly,
              style: widget.style,
              textAlign: TextAlign.left,
              textInputAction: widget.textInputAction,
              textAlignVertical: TextAlignVertical.top,
              inputFormatters:
                  widget.inputFormatter ??
                  [
                    LengthLimitingTextInputFormatter(widget.maxLength),

                    // Allow only alphabets and spaces for name input
                    if (widget.inputType == TextInputType.name)
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                    // Allow only digits (no decimals)
                    else if (widget.inputType == TextInputType.number &&
                        widget.hasInputFormat) ...[
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                      AmountTextInputFormatter(),
                    ]
                    // Allow decimal numbers with custom formatter
                    else if ((widget.inputType == TextInputType.number ||
                            widget.inputType ==
                                const TextInputType.numberWithOptions(
                                  decimal: true,
                                )) &&
                        widget.hasInputFormat)
                      AmountTextInputFormatter(),
                  ],
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 21,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 10,
                ),
                fillColor: widget.backgroundColor ?? AppColors.rexWhite,
                filled: true,
                hintText: widget.hintText,
                hintStyle:
                    widget.hintStyle ??
                    TextStyle(color: AppColors.grey.withOpacity(0.5)),
                errorText: widget.errorText,
                errorStyle: const TextStyle(color: AppColors.red),
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                border: inputBorder,
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RemoveFirstDigitOnPasteFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final isPaste = (newValue.text.length - oldValue.text.length) > 1;

    if (isPaste && newValue.text.length > 10) {
      final modifiedText = newValue.text.substring(1);

      return TextEditingValue(
        text: modifiedText,
        selection: TextSelection.collapsed(offset: modifiedText.length),
      );
    }

    return newValue;
  }
}

class AmountTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final numericValue = int.tryParse(newValue.text.replaceAll(',', ''));

    if (numericValue != null) {
      final commaFormattedValue = NumberFormat('#,##0').format(numericValue);

      return newValue.copyWith(
        text: commaFormattedValue,
        selection: TextSelection.collapsed(offset: commaFormattedValue.length),
      );
    }

    return newValue;
  }
}
