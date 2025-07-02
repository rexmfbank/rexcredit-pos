import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/provider/data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../shared/widgets/modal_bottom_sheets/show_status_modal_sheet.dart';
import '../../../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../../../shared/widgets/page_widgets/custom_app_bar.dart';
import '../../shared/widgets/confirm_transaction_item.dart';
import '../../shared/providers/bill_payment_provider.dart';

class BillPaymentDataConfirmScreen extends ConsumerWidget {
  const BillPaymentDataConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(billPaymentDataProvider);

    ref.listen(billPaymentDataProvider, (previous, next) {
      if (next.postBillPaymentSuccess != null) {
        var planName =
            ref.watch(billPaymentDataProvider).dataPlanController.text;

        showStatusModal(
          context: context,
          title: StringAssets.dataSuccessful,
          subtitle: StringAssets.dataSuccessfulInfo(planName),
          buttonText: StringAssets.ok,
          isSuccess: true,
          onButtonPressed: () {
            ref.read(billPaymentProvider.notifier).popUp(context);
          },
          onCloseTapped: () {
            ref.read(billPaymentProvider.notifier).popUp(context);
          },
        );
      }

      if (next.apiError.isNotBlank) {
        showStatusModal(
          context: context,
          title: StringAssets.dataFailed,
          subtitle: next.apiError!,
          buttonText: StringAssets.ok,
          isSuccess: false,
          onButtonPressed: () {
            context.pop();
          },
          onCloseTapped: () {
            context.pop();
          },
        );
      }
    });

    return AppScaffold(
      isLoading: ref.watch(billPaymentDataProvider).isLoading,
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
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConfirmTransactionItem(
                  label: StringAssets.biller,
                  value: state.selectedServiceProvider?.billerName ?? 'N/A',
                ),
                const Divider(),
                ConfirmTransactionItem(
                  label: StringAssets.dataPlan,
                  value: state.selectedDataPlan?.productName ?? 'N/A',
                ),
                const Divider(),
                ConfirmTransactionItem(
                  label: StringAssets.beneficiaryPhoneNumber,
                  value: state.phoneNumberController.text,
                ),
                const Divider(),
                ConfirmTransactionItem(
                  label: StringAssets.amount,
                  value: '₦${state.selectedDataPlan?.amount ?? 'N/A'}',
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          RexElevatedButton(
            onPressed: () {
              ref.read(billPaymentDataProvider.notifier).updateApiError();
              ref
                  .read(billPaymentDataProvider.notifier)
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
