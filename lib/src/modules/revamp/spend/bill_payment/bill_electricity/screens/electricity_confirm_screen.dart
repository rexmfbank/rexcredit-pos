import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_electricity/provider/electricity_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../shared/widgets/modal_bottom_sheets/show_status_modal_sheet.dart';
import '../../../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../../../shared/widgets/page_widgets/custom_app_bar.dart';
import '../../shared/widgets/confirm_transaction_item.dart';

class ElectricityConfirmScreen extends ConsumerWidget {
  const ElectricityConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(electricityProvider);
    final amount = state.amountController.text;
    final meterNo = state.meterTypeController.text;

    return AppScaffold(
      isLoading: ref.watch(electricityProvider).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: StringAssets.confirmTransaction,
        subtitle: StringAssets.reviewTransactionDetails,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.rexWhite,
                borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConfirmTransactionItem(
                  label: StringAssets.biller,
                  value: state.selectedServiceProvider?.billerName ?? 'N/A',
                ),
                const Divider(),
                ConfirmTransactionItem(
                  label: StringAssets.meterType,
                  value: state.meterTypeController.text,
                ),
                const Divider(),
                ConfirmTransactionItem(
                  label: StringAssets.beneficiaryName,
                  value: state.validateBillData?.customerName ?? 'N/A',
                ),
                const Divider(),
                ConfirmTransactionItem(
                  label: StringAssets.amount,
                  value: '₦${state.amountController.text}',
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          RexElevatedButton(
            onPressed: () {
              ref
                  .read(electricityProvider.notifier)
                  .showPaymentMethodModal(context);
            },
            buttonTitle: StringAssets.makePayment,
            backgroundColor: null,
          ),
        ],
      ),
    );
  }
}
