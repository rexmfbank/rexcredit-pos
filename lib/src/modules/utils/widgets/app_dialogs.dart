import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

Future<T?> showAppDialogCardBalance<T>({
  required BuildContext context,
  required String statusCode,
  required Function()? onPressed,
  String amount = '',
}) {
  final String title;
  final String body;
  final IconData icon;

  switch (statusCode) {
    case '00':
      title = 'Card Balance';
      body = 'Your card balance is: ${amount.formatCurrencyString()}';
      icon = Icons.check;
      break;
    case '55':
      title = 'Incorrect PIN';
      body = 'The PIN you entered is incorrect. Please try again.';
      icon = Icons.error_outline;
      break;
    default:
      title = 'Unable to Get Balance';
      body = 'Could not retrieve your card balance. Please try again.';
      icon = Icons.warning_amber_rounded;
      break;
  }

  return showAppDialog(
    context: context,
    title: title,
    body: body,
    icon: icon,
    onPressed: onPressed,
  );
}

Future<T?> showAppDialogTransSuccess<T>({
  required BuildContext context,
  required Function()? onPressed,
}) {
  return showAppDialog(
    context: context,
    title: 'Transaction Success',
    body: 'Your transfer was successful',
    icon: Icons.check_circle,
    onPressed: onPressed,
  );
}

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required String title,
  required String body,
  required IconData icon,
  required Function()? onPressed,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 35),
            SizedBox(height: 8),
            Text(title, style: TextStyle(color: AppColors.rexPurpleLight)),
            SizedBox(height: 8),
            Text(body, textAlign: TextAlign.center),
            SizedBox(height: 8),
            RexElevatedButton(
              onPressed: onPressed ?? () => context.pop(),
              buttonTitle: 'OK',
            ),
          ],
        ),
      );
    },
  );
}

/// Shows a PIN entry dialog that captures a 4-digit PIN from the
/// physical keyboard only (on-screen keyboard is disabled).
///
/// Returns the 4-digit PIN [String] when the user presses **Confirm**,
/// or `null` if the dialog is dismissed without confirming.
///
/// Example:
/// ```dart
/// final pin = await showPinDialog(context: context);
/// if (pin != null) { /* use the pin */ }
/// ```
Future<String?> showPinDialog({
  required BuildContext context,
  bool barrierDismissible = true,
}) {
  return showDialog<String>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        content: const _PinDialogContent(),
      );
    },
  );
}

/// Internal stateful widget that renders the PIN entry UI inside the dialog.
class _PinDialogContent extends StatefulWidget {
  const _PinDialogContent();

  @override
  State<_PinDialogContent> createState() => _PinDialogContentState();
}

class _PinDialogContentState extends State<_PinDialogContent> {
  final FocusNode _focusNode = FocusNode();
  String _pin = '';
  static const int _pinLength = 4;

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

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final key = event.logicalKey;

    setState(() {
      if (RegExp(r'^[0-9]$').hasMatch(key.keyLabel) &&
          _pin.length < _pinLength) {
        _pin += key.keyLabel;
      } else if (key == LogicalKeyboardKey.backspace && _pin.isNotEmpty) {
        _pin = _pin.substring(0, _pin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKey,
        autofocus: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Transaction PIN',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleDark,
              ),
            ),
            const SizedBox(height: 24),
            // PIN boxes container with light blue background
            Container(
              key: ValueKey('pxt'),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.rexLightBlue4,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: List.generate(_pinLength * 2 - 1, (i) {
                  // Odd indices are spacing between boxes
                  if (i.isOdd) return const SizedBox(width: 8);
                  final index = i ~/ 2;
                  final hasValue = index < _pin.length;
                  return Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.rexWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                hasValue
                                    ? AppColors.rexPurpleLight
                                    : AppColors.grey2,
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          hasValue ? _pin[index] : '0',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color:
                                hasValue
                                    ? AppColors.rexPurpleDark
                                    : AppColors.softGrey,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            RexElevatedButton(
              onPressed:
                  _pin.length == _pinLength
                      ? () => Navigator.of(context).pop(_pin)
                      : null,
              isDisabled: _pin.length != _pinLength,
              buttonTitle: 'Confirm',
            ),
          ],
        ),
      ),
    );
  }
}
