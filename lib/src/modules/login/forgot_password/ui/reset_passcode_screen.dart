import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/forgot_password/provider/forgot_password_provider.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';

class ResetPasscodeScreen extends ConsumerWidget {
  const ResetPasscodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);

    return AppScaffold(
      isLoading: state.isLoading,
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarLoginScreen(
        onBackBtnPress: () => context.pop(),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.aw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Passcode',
                  style: TextStyle(
                    fontSize: 28.asp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                SizedBox(height: 6.ah),
                Text(
                  'Enter the code sent to your email and set a new passcode',
                  style: TextStyle(
                    fontSize: 14.asp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.rexTint500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.aw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DeviceKeypadPasscodeField(
                  controller: state.otp,
                  outerTitle: 'Passcode',
                  hintText: 'Enter 6-digit passcode',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 4.ah),
                _DeviceKeypadPasscodeField(
                  controller: state.newPasscode,
                  outerTitle: 'New Passcode',
                  hintText: 'Enter 6-digit passcode',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 4.ah),
                _DeviceKeypadPasscodeField(
                  controller: state.confirmPasscode,
                  outerTitle: 'Confirm Passcode',
                  hintText: 'Confirm 6-digit passcode',
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexElevatedButton(
              onPressed: () {
                ref
                    .read(forgotPasswordProvider.notifier)
                    .resetPasscode(context);
              },
              buttonTitle: 'Reset Passcode',
            ),
          ),
          SizedBox(height: 24.ah),
        ],
      ),
    );
  }
}

/// Passcode field that accepts digits from the device number pad only
/// (no on-screen soft keyboard).
class _DeviceKeypadPasscodeField extends StatefulWidget {
  const _DeviceKeypadPasscodeField({
    required this.controller,
    required this.outerTitle,
    required this.hintText,
    required this.textInputAction,
  });

  final TextEditingController controller;
  final String outerTitle;
  final String hintText;
  final TextInputAction textInputAction;

  @override
  State<_DeviceKeypadPasscodeField> createState() =>
      _DeviceKeypadPasscodeFieldState();
}

class _DeviceKeypadPasscodeFieldState
    extends State<_DeviceKeypadPasscodeField> {
  late final FocusNode _focusNode = FocusNode();

  static const _maxLength = 6;

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
      if (text.length < _maxLength) {
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

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _handleKey,
      child: RexTextField(
        controller: widget.controller,
        focusNode: _focusNode,
        outerTitle: widget.outerTitle,
        showOuterTile: true,
        hintText: widget.hintText,
        obscureText: true,
        maxLength: _maxLength,
        // No soft keyboard — input comes from the device number pad.
        inputType: TextInputType.none,
        readOnly: true,
        showCursor: true,
        textInputAction: widget.textInputAction,
        horizontalPadding: 0,
        inputFormatter: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(_maxLength),
        ],
      ),
    );
  }
}
