import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

/// A reusable widget that captures digits from a physical keyboard
/// and formats them for display.
///
/// Similar to [TextField], it exposes:
///   * focusNode – to share focus between widgets,
///   * onChanged – notifies callers whenever the input changes,
///   * initialValue / decoration / style – basic customisation.
///
/// Example:
/// ```dart
/// final focus = FocusNode();
///
/// TopwiseInputerDynamic(
///   focusNode: focus,
///   onChanged: (value) => debugPrint('Current raw value: $value'),
/// )
/// ```
class TopwiseInputerDynamic extends StatefulWidget {
  const TopwiseInputerDynamic({
    super.key,
    this.focusNode,
    this.initialValue = '',
    this.onChanged,
    this.decoration,
    this.textStyle,
    this.formatter,
    required this.textContainerHeight,
  });

  /// Provide a [FocusNode] to control keyboard focus externally.
  final FocusNode? focusNode;

  /// Starting text (unformatted).
  final String initialValue;

  /// Called every time the underlying numeric string changes.
  final ValueChanged<String>? onChanged;

  /// Visuals for the outer container (defaults to a 1.5-pt border & 12-px radius).
  final BoxDecoration? decoration;

  /// Text styling inside the field.
  final TextStyle? textStyle;

  /// Optional formatter – fallback is `formatCurrencyString()`.
  final String Function(String value)? formatter;

  final double textContainerHeight;

  @override
  State<TopwiseInputerDynamic> createState() => _TopwiseInputerDynamicState();
}

class _TopwiseInputerDynamicState extends State<TopwiseInputerDynamic> {
  late final FocusNode _internalFocus = widget.focusNode ?? FocusNode();
  late String _value = widget.initialValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.focusNode == null) _internalFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _internalFocus.dispose();
    super.dispose();
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final key = event.logicalKey;

    setState(() {
      if (RegExp(r'^[0-9]$').hasMatch(key.keyLabel)) {
        _value += key.keyLabel;
      } else if (key == LogicalKeyboardKey.backspace && _value.isNotEmpty) {
        _value = _value.substring(0, _value.length - 1);
      }
      widget.onChanged?.call(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _internalFocus.requestFocus(),
      child: KeyboardListener(
        focusNode: _internalFocus,
        onKeyEvent: _handleKey,
        autofocus: widget.focusNode == null,
        child: Container(
          width: double.infinity,
          height: widget.textContainerHeight,
          decoration:
              widget.decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1.5),
              ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            (widget.formatter ?? (s) => s.formatCurrencyString())(_value),
            style:
                widget.textStyle ??
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
