import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/_keyboard/keyboard_overlay.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexSearchField extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController controller;
  final String hint;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onEditingComplete;
  final Color? cursorColor;
  final Color? borderColor;
  final Color? enabledBorderColor;
  final double? borderRadius;
  final double? height;
  final bool expand;
  final int? maxLines;
  final int? minLines;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final VoidCallback? downArrowAction;
  final VoidCallback? upArrowAction;

  const RexSearchField({
    Key? key,
    this.onTap,
    this.onEditingComplete,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.focusNode,
    this.upArrowAction,
    this.downArrowAction,
    this.suffixIcon,
    this.suffixWidget,
    this.cursorColor,
    this.borderColor,
    this.borderRadius,
    this.height,
    this.maxLines,
    this.minLines,
    this.enabledBorderColor,
    this.textStyle,
    this.hintStyle,
    this.expand = false,
  }) : super(key: key);

  @override
  State<RexSearchField> createState() => _RexSearchFieldState();
}

class _RexSearchFieldState extends State<RexSearchField> {
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
    return SizedBox(
      height: widget.height ?? 50.ah,
      child: TextField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.aw),
          prefixIcon: SvgPicture.asset(
            AssetPath.search,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: widget.suffixWidget ?? InkWell(
            onTap: widget.onTap,
            child: SizedBox(
              height: 20.ah,
              width: 20.aw,
              child: widget.suffixIcon,
            ),
          ),
          hintText: widget.hint,
          hintStyle: widget.hintStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius ?? 6.ar),
            ),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.rexWhite,
            ),
          ),
          focusColor: widget.enabledBorderColor ?? AppColors.rexWhite,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius ?? 6.ar),
            ),
            borderSide: BorderSide(
              color: widget.enabledBorderColor ?? AppColors.rexWhite,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius ?? 6.ar),
            ),
            borderSide: BorderSide(
              color: widget.enabledBorderColor ?? AppColors.textGrey,
            ),
          ),
          fillColor: AppColors.rexWhite,
          filled: true,
        ),
        expands: widget.expand,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        cursorColor: widget.cursorColor ?? AppColors.rexPurpleLight,
        cursorWidth: 1.aw,
        style: widget.textStyle ?? AppTextStyles.body1Regular,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onEditingComplete,
      ),
    );
  }
}
