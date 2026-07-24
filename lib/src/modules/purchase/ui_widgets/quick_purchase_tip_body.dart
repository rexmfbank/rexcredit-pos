import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/topwise_inputer_dynamic.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/waiter_code_dialog.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';

class QuickPurchaseTipBody extends ConsumerWidget {
  const QuickPurchaseTipBody({super.key});

  static const _presets = ['500', '1000', '2000', '3000'];

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    final notifier = ref.read(posCardPurchaseProvider.notifier);
    final isTopwise = Pkg.isTopwise(state.baseappName);
    final totalLabel = notifier.totalChargeAmount.toString().toNairaAmountFormat();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.h),
          if (isTopwise)
            TopwiseInputerDynamic(
              textContainerHeight: 72.h,
              initialValue: state.tipAmount,
              textStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
              onChanged: notifier.setTipAmount,
            )
          else
            _SoftTipInput(
              initialValue: state.tipAmount,
              onChanged: notifier.setTipAmount,
            ),
          SizedBox(height: 16.h),
          Row(
            children: [
              for (var i = 0; i < _presets.length; i++) ...[
                if (i > 0) SizedBox(width: 8.w),
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark3,
                  ),
                ),
                Text(
                  totalLabel,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexPurpleDark3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: notifier.selectNoTip,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.rexPurpleLight,
                      side: const BorderSide(
                        color: AppColors.rexPurpleLight,
                        width: 1.5,
                      ),
                      minimumSize: Size(0, 52.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'No Tip',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () => _onContinue(context, ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.rexPurpleLight,
                        foregroundColor: AppColors.rexWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
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
      color: AppColors.rexWhite,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.rexPurpleLight
                      : AppColors.dividerGreyLight,
            ),
          ),
          child: Text(
            amount,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.rexPurpleDark3,
            ),
          ),
        ),
      ),
    );
  }
}

/// Soft-keyboard tip entry for non-Topwise devices.
class _SoftTipInput extends StatefulWidget {
  const _SoftTipInput({
    required this.initialValue,
    required this.onChanged,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<_SoftTipInput> createState() => _SoftTipInputState();
}

class _SoftTipInputState extends State<_SoftTipInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _SoftTipInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final display =
        _controller.text.isEmpty
            ? '₦0.00'
            : _controller.text.toNairaAmountFormat();

    return Container(
      height: 72.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            display,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color:
                  _controller.text.isEmpty
                      ? AppColors.grey
                      : AppColors.rexPurpleDark3,
            ),
          ),
          Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
