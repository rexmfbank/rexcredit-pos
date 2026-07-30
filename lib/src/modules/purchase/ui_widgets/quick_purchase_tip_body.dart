import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/waiter_code_dialog.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/extension_on_snackbar.dart';

class QuickPurchaseTipBody extends ConsumerWidget {
  const QuickPurchaseTipBody({super.key});

  static const _presets = ['500', '1000', '2000', '3000'];
  static const _buttonRadius = 8.0;
  static const _cardRadius = 16.0;
  static const _primary = AppColors.rexPurpleLight;

  Future<void> _onContinue(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(posCardPurchaseProvider.notifier);
    final tip = notifier.tipValue;
    if (tip <= 0) {
      context.showSnack(message: 'Enter a tip or select No Tip');
      return;
    }
    final code = await showWaiterCodeDialog(context: context);
    if (code == null || code.length != 4) return;
    notifier.continueWithTip(waiterCode: code);
  }

  String _formatTotal(num amount) {
    return amount.toStringAsFixed(0).formatCurrencyString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    final notifier = ref.read(posCardPurchaseProvider.notifier);
    final isTopwise = Pkg.isTopwise(state.baseappName);
    final totalLabel = _formatTotal(notifier.totalChargeAmount);

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TipAmountField(
            value: state.tipAmount,
            useHardwareKeys: isTopwise,
            onChanged: notifier.setTipAmount,
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              for (var i = 0; i < _presets.length; i++) ...[
                if (i > 0) SizedBox(width: 10.w),
                Expanded(
                  child: _TipPresetButton(
                    amount: _presets[i],
                    isSelected: state.tipAmount == _presets[i],
                    onTap: () => notifier.setTipAmount(_presets[i]),
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(_cardRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
                Text(
                  totalLabel,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: notifier.selectNoTip,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.rexWhite,
                        foregroundColor: _primary,
                        side: const BorderSide(color: _primary, width: 1.5),
                        minimumSize: const Size(0, 56),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_buttonRadius),
                        ),
                      ),
                      child: Text(
                        'No Tip',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: _primary,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _onContinue(context, ref),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _primary,
                        foregroundColor: AppColors.rexWhite,
                        minimumSize: const Size(0, 56),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_buttonRadius),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipAmountField extends StatefulWidget {
  const _TipAmountField({
    required this.value,
    required this.onChanged,
    required this.useHardwareKeys,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final bool useHardwareKeys;

  @override
  State<_TipAmountField> createState() => _TipAmountFieldState();
}

class _TipAmountFieldState extends State<_TipAmountField> {
  late final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller;
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _controller = TextEditingController(text: widget.value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void didUpdateWidget(covariant _TipAmountField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _value) {
      setState(() => _value = widget.value);
      if (!widget.useHardwareKeys && _controller.text != widget.value) {
        _controller.text = widget.value;
        _controller.selection = TextSelection.collapsed(
          offset: _controller.text.length,
        );
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _setValue(String next) {
    setState(() => _value = next);
    widget.onChanged(next);
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final key = event.logicalKey;
    if (RegExp(r'^[0-9]$').hasMatch(key.keyLabel)) {
      _setValue(_value + key.keyLabel);
    } else if (key == LogicalKeyboardKey.backspace && _value.isNotEmpty) {
      _setValue(_value.substring(0, _value.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = _value.isEmpty;
    final display = isEmpty ? '₦0.00' : _value.toNairaAmountFormat();

    final field = Container(
      height: 120.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            display,
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: isEmpty ? const Color(0xFFB0B0B0) : AppColors.rexPurpleDark3,
            ),
          ),
          if (!widget.useHardwareKeys)
            Opacity(
              opacity: 0,
              child: TextField(
                focusNode: _focusNode,
                controller: _controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                onChanged: _setValue,
              ),
            ),
        ],
      ),
    );

    if (!widget.useHardwareKeys) return field;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKey,
        autofocus: true,
        child: field,
      ),
    );
  }
}

class _TipPresetButton extends StatelessWidget {
  const _TipPresetButton({
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  final String amount;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.rexWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border:
                isSelected
                    ? Border.all(color: AppColors.rexPurpleLight, width: 1.5)
                    : null,
          ),
          child: Text(
            amount,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.rexPurpleDark3,
            ),
          ),
        ),
      ),
    );
  }
}
