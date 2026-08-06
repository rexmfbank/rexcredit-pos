import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';

/// Shared formatters for every passcode / OTP field: digits only, no whitespace.
List<TextInputFormatter> passcodeInputFormatters({int maxLength = 6}) => [
      FilteringTextInputFormatter.deny(RegExp(r'\s')),
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
    ];

/// Passcode field that accepts digits from the device number pad only
/// (no on-screen soft keyboard).
class RexPasscodeField extends StatefulWidget {
  const RexPasscodeField({
    super.key,
    required this.controller,
    required this.outerTitle,
    required this.hintText,
    required this.textInputAction,
    this.autoFocus = false,
    this.maxLength = 6,
  });

  final TextEditingController controller;
  final String outerTitle;
  final String hintText;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final int maxLength;

  @override
  State<RexPasscodeField> createState() => _RexPasscodeFieldState();
}

class _RexPasscodeFieldState extends State<RexPasscodeField> {
  late final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final key = event.logicalKey;
    final text = widget.controller.text;

    if (RegExp(r'^[0-9]$').hasMatch(key.keyLabel)) {
      if (text.length < widget.maxLength) {
        final next = text + key.keyLabel;
        widget.controller.value = TextEditingValue(
          text: next,
          selection: TextSelection.collapsed(offset: next.length),
        );
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.backspace && text.isNotEmpty) {
      final next = text.substring(0, text.length - 1);
      widget.controller.value = TextEditingValue(
        text: next,
        selection: TextSelection.collapsed(offset: next.length),
      );
      return KeyEventResult.handled;
    }

    // Block space (and other printable non-digits) without swallowing
    // navigation keys like Tab / Enter.
    if (key == LogicalKeyboardKey.space ||
        (key.keyLabel.length == 1 && !RegExp(r'[0-9]').hasMatch(key.keyLabel))) {
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _handleKey,
      child: RexTextField(
        controller: widget.controller,
        focusNode: _focusNode,
        autoFocus: widget.autoFocus,
        outerTitle: widget.outerTitle,
        showOuterTile: true,
        hintText: widget.hintText,
        obscureText: _obscureText,
        maxLength: widget.maxLength,
        // No soft keyboard — input comes from the device number pad.
        inputType: TextInputType.none,
        readOnly: true,
        showCursor: true,
        textInputAction: widget.textInputAction,
        horizontalPadding: 0,
        enableSuggestions: false,
        autocorrect: false,
        inputFormatter: passcodeInputFormatters(maxLength: widget.maxLength),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

/// Passcode field that uses the soft number keyboard and supports show/hide.
class RexSoftPasscodeField extends StatefulWidget {
  const RexSoftPasscodeField({
    super.key,
    required this.controller,
    required this.outerTitle,
    required this.hintText,
    required this.textInputAction,
    this.maxLength = 6,
  });

  final TextEditingController controller;
  final String outerTitle;
  final String hintText;
  final TextInputAction textInputAction;
  final int maxLength;

  @override
  State<RexSoftPasscodeField> createState() => _RexSoftPasscodeFieldState();
}

class _RexSoftPasscodeFieldState extends State<RexSoftPasscodeField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return RexTextField(
      controller: widget.controller,
      outerTitle: widget.outerTitle,
      showOuterTile: true,
      hintText: widget.hintText,
      obscureText: _obscureText,
      maxLength: widget.maxLength,
      inputType: TextInputType.number,
      textInputAction: widget.textInputAction,
      horizontalPadding: 0,
      enableSuggestions: false,
      autocorrect: false,
      inputFormatter: passcodeInputFormatters(maxLength: widget.maxLength),
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
