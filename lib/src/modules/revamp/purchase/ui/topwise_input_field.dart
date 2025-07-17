import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TopwiseInputField extends ConsumerStatefulWidget {
  const TopwiseInputField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TopwiseInputFieldState();
}

class _TopwiseInputFieldState extends ConsumerState<TopwiseInputField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (keyEvent) {
        if (keyEvent is KeyDownEvent) {
          final label = keyEvent.logicalKey.keyLabel;
          if (RegExp(r'^[0-9]$').hasMatch(label)) {
            _controller.text += label;
          }
          if (keyEvent.logicalKey == LogicalKeyboardKey.backspace &&
              _controller.text.isNotEmpty) {
            _controller.text = _controller.text.substring(
              0,
              _controller.text.length - 1,
            );
          }
        }
      },
      // child: RexTextField(
      //   prefixIcon: const RexTextFieldCurrencyWidget(),
      //   outerTitle: StringAssets.amount,
      //   hintText: 'Enter amount',
      //   controller: _controller,
      //   readOnly: true,
      //   showCursor: true,
      //   validator: (value) {
      //     return TextfieldValidator.minAmount(minAmount: 50, value: value);
      //   },
      //   // inputType: TextInputType.none,
      //   // inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      //   inputType: const TextInputType.numberWithOptions(decimal: true),
      //   hasInputFormat: true,
      //   inputFormatter: [
      //     FilteringTextInputFormatter.allow(RegExp(r'\d')),
      //     AmountTextInputFormatter(),
      //   ],
      // ),
      child: TextField(
        controller: _controller,
        readOnly: true,
        keyboardType: TextInputType.none,
        inputFormatters: [ThousandsSeparatorInputFormatter()],
        showCursor: true,
        decoration: const InputDecoration(
          labelText: 'Amount',
          hintText: 'Use physical keypad',
          suffixIcon: Icon(Icons.keyboard_alt_outlined),
        ),
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const _separator = ',';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Strip existing commas
    final digitsOnly = newValue.text.replaceAll(_separator, '');

    // Short-circuit on empty input
    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Re-inject commas from the right
    final chars = digitsOnly.split('').reversed.toList();
    final buf = StringBuffer();
    for (int i = 0; i < chars.length; i++) {
      if (i != 0 && i % 3 == 0) buf.write(_separator);
      buf.write(chars[i]);
    }

    final formatted = buf.toString().split('').reversed.join('');
    final selection = TextSelection.collapsed(
      offset:
          formatted.length - (oldValue.text.length - oldValue.selection.end),
    );

    return TextEditingValue(text: formatted, selection: selection);
  }
}
