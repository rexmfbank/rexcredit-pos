import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class RexTextFieldPassword extends StatefulWidget {
  const RexTextFieldPassword({
    super.key,
    required this.outerTitle,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffixOuterTitle,
    this.onTapSuffixOuterTitle,
    this.verticalPadding,
    this.horizontalPadding,
    this.textFieldIsRequired = false,
    this.onChanged,
    //this.onPressed,
    this.enableSuggestions,
    this.autofillHints,
    this.autocorrect,
  });

  final String outerTitle;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? suffixOuterTitle;
  final double? verticalPadding;
  final double? horizontalPadding;
  final void Function()? onTapSuffixOuterTitle;
  final bool textFieldIsRequired;
  final bool obscureText;
  final void Function(String)? onChanged;
  //final void Function()? onPressed;
  final bool? enableSuggestions;
  final Iterable<String>? autofillHints;
  final bool? autocorrect;

  @override
  State<RexTextFieldPassword> createState() => _RexTextFieldPasswordState();
}

class _RexTextFieldPasswordState extends State<RexTextFieldPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return RexTextField(
      enableSuggestions: widget.enableSuggestions,
      autofillHints: widget.autofillHints,
      autocorrect: widget.autocorrect,
      hintText: widget.hintText,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: showPassword,
      showOuterTile: true,
      outerTitle: widget.outerTitle,
      suffixOuterTitle: widget.suffixOuterTitle,
      onTapSuffixOuterTitle: widget.onTapSuffixOuterTitle,
      verticalPadding: widget.verticalPadding,
      horizontalPadding: widget.horizontalPadding,
      maxLines: 1,
      textFieldIsRequired: widget.textFieldIsRequired,
      onChanged: widget.onChanged,
      suffixIcon: IconButton(
        icon: showPassword
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off),
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
      ),
    );
  }
}
