import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PosTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const PosTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<PosTextFormField> createState() => _PosTextFormFieldState();
}

class _PosTextFormFieldState extends State<PosTextFormField> {
  late FocusNode _internalFocusNode;
  late TextEditingController _internalController;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;
  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    if (widget.controller == null) {
      _internalController = TextEditingController();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (!_effectiveFocusNode.hasFocus) {
      _effectiveFocusNode.requestFocus();
      // Directly invoke the platform channel to bypass scheduling latency
      SystemChannels.textInput.invokeMethod<void>('TextInput.show');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: _handlePointerDown,
      child: TextFormField(
        controller: _effectiveController,
        focusNode: _effectiveFocusNode,
        keyboardType: widget.keyboardType,
        decoration: widget.decoration,
        onChanged: widget.onChanged,
        onTapOutside: (PointerDownEvent event) {
          _effectiveFocusNode.unfocus();
        },
      ),
    );
  }
}
