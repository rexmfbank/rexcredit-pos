import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class TopwiseInputer extends ConsumerStatefulWidget {
  const TopwiseInputer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopwiseInputerState();
}

class _TopwiseInputerState extends ConsumerState<TopwiseInputer> {
  String _inputNum = "";
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: KeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKeyEvent: (keyEvent) {
          if (keyEvent is KeyDownEvent) {
            final label = keyEvent.logicalKey.keyLabel;
            if (RegExp(r'^[0-9]$').hasMatch(label)) {
              setState(() {
                _inputNum += label;
              });
            }
            if (keyEvent.logicalKey == LogicalKeyboardKey.backspace &&
                _inputNum.isNotEmpty) {
              setState(() {
                _inputNum = _inputNum.substring(0, _inputNum.length - 1);
              });
            }
          }
        },
        child: Container(
          width: double.infinity,
          height: 100.ah,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _inputNum.formatCurrencyString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
