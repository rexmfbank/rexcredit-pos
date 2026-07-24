import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

class QuickPurchaseReviewBody extends ConsumerWidget {
  const QuickPurchaseReviewBody({super.key});

  static const _buttonRadius = 8.0;
  static const _cardRadius = 12.0;
  static const _primary = AppColors.rexPurpleLight;
  static const _cardBg = AppColors.rexLightBlue4;

  String _formatAmount(num value) => '₦${value.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posCardPurchaseProvider);
    final notifier = ref.read(posCardPurchaseProvider.notifier);
    final tipLabel = notifier.tipPercentageLabel() ?? 'Tip';
    final hasTip = notifier.tipValue > 0;
    final hasWaiter = state.waiterCode.isNotEmpty;

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Confirm the breakdown before payment',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.subtitleGrey,
              height: 1.3,
            ),
          ),
          SizedBox(height: 28.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(_cardRadius),
            ),
            child: Column(
              children: [
                _ReviewRow(
                  label: 'Purchase Amount',
                  value: _formatAmount(notifier.purchaseValue),
                ),
                SizedBox(height: 18.h),
                _ReviewRow(
                  label: tipLabel,
                  value: _formatAmount(hasTip ? notifier.tipValue : 0),
                ),
                if (hasWaiter) ...[
                  SizedBox(height: 18.h),
                  _ReviewRow(label: 'Waiter Code', value: state.waiterCode),
                ],
                SizedBox(height: 16.h),
                Divider(color: AppColors.dividerGreyLight, height: 1, thickness: 1),
                SizedBox(height: 16.h),
                _ReviewRow(
                  label: 'Total',
                  value: _formatAmount(notifier.totalChargeAmount),
                  isBold: true,
                ),
              ],
            ),
          ),
          const Spacer(),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          () => notifier.confirmAndPay(quickPurchase: true),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _primary,
                        foregroundColor: AppColors.rexWhite,
                        minimumSize: Size(double.infinity, 56),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_buttonRadius),
                        ),
                      ),
                      child: Text(
                        'Confirm and Pay',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.rexWhite,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: notifier.editTip,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _cardBg,
                        foregroundColor: _primary,
                        disabledForegroundColor: _primary,
                        shadowColor: Colors.transparent,
                        minimumSize: Size(double.infinity, 56),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_buttonRadius),
                        ),
                      ),
                      child: Text(
                        'Edit Tip',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: _primary,
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
    final color = isBold ? AppColors.rexPurpleDark3 : AppColors.textGrey;
    final style = TextStyle(
      fontSize: 14.sp,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      color: isBold ? AppColors.rexPurpleDark3 : color,
    );
    final valueStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
      color: AppColors.rexPurpleDark3,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: valueStyle),
      ],
    );
  }
}
