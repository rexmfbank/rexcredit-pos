import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

class QuickPurchaseReviewBody extends ConsumerWidget {
  const QuickPurchaseReviewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    final notifier = ref.read(posCardPurchaseProvider.notifier);
    final tipLabel = notifier.tipPercentageLabel() ?? 'Tip';
    final hasTip = notifier.tipValue > 0;
    final hasWaiter = state.waiterCode.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.h),
          Text(
            'Confirm the breakdown before payment',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subtitleGrey,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColors.rexLightBlue4,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                _ReviewRow(
                  label: 'Purchase Amount',
                  value: state.purchaseAmount.toNairaAmountFormat(),
                ),
                SizedBox(height: 14.h),
                _ReviewRow(
                  label: tipLabel,
                  value:
                      hasTip
                          ? state.tipAmount.toNairaAmountFormat()
                          : '0'.toNairaAmountFormat(),
                ),
                if (hasWaiter) ...[
                  SizedBox(height: 14.h),
                  _ReviewRow(label: 'Waiter Code', value: state.waiterCode),
                ],
                SizedBox(height: 14.h),
                Divider(color: AppColors.dividerGreyLight, height: 1.h),
                SizedBox(height: 14.h),
                _ReviewRow(
                  label: 'Total',
                  value: notifier.totalChargeAmount
                      .toString()
                      .toNairaAmountFormat(),
                  isBold: true,
                ),
              ],
            ),
          ),
          const Spacer(),
          SafeArea(
            top: false,
            child: Column(
              children: [
                RexElevatedButton(
                  buttonTitle: 'Confirm and Pay',
                  verticalPadding: 8,
                  onPressed:
                      () => notifier.confirmAndPay(quickPurchase: true),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: notifier.editTip,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.rexLightBlue4,
                      foregroundColor: AppColors.rexPurpleLight,
                      minimumSize: Size(0, 52.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Edit Tip',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.rexPurpleLight,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isBold ? 16.sp : 14.sp,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
      color: AppColors.rexPurpleDark3,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
