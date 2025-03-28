import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class RexTextFieldPassword extends StatefulWidget {
  const RexTextFieldPassword({
    super.key,
    required this.outerTitle,
    required this.hintText,
    required this.controller,
    this.validator,
    this.suffixOuterTitle,
    this.onTapSuffixOuterTitle,
    this.verticalPadding,
    this.horizontalPadding,
    this.textFieldIsRequired = false,
    this.onChanged,
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
  final void Function(String)? onChanged;

  @override
  State<RexTextFieldPassword> createState() => _RexTextFieldPasswordState();
}

class _RexTextFieldPasswordState extends State<RexTextFieldPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return RexTextField(
      hintText: widget.hintText,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: showPassword ? false : true,
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
