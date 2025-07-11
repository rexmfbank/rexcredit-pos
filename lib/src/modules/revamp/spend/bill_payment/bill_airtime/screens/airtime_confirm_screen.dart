import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_airtime/provider/airtime_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../shared/widgets/modal_bottom_sheets/show_status_modal_sheet.dart';
import '../../../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../../../shared/widgets/page_widgets/custom_app_bar.dart';
import '../../shared/widgets/confirm_transaction_item.dart';
import '../../shared/providers/bill_payment_provider.dart';

class AirtimeConfirmScreen extends ConsumerWidget {
  const AirtimeConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(airtimeProvider);

    ref.listen(airtimeProvider, (previous, next) {
      if (next.postBillPaymentSuccess != null) {
        var amount = ref.watch(airtimeProvider).amountController.text;
        var phoneNo = ref.watch(airtimeProvider).phoneNumberController.text;

        showStatusModal(
          context: context,
          title: StringAssets.airtimeSuccessful,
          subtitle: StringAssets.successfulAirtimePaymentInfo(amount, phoneNo),
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
          title: StringAssets.airtimeFailed,
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
      isLoading: ref.watch(airtimeProvider).isLoading,
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
                  label: StringAssets.networkProvider,
                  value: state.selectedServiceProvider?.billerName ?? "N/A",
                ),
                const Divider(),
                ConfirmTransactionItem(
                  label: StringAssets.beneficiaryPhoneNumber,
                  value: state.phoneNumberController.text,
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
              ref.read(airtimeProvider.notifier).updateApiError();
              ref
                  .read(airtimeProvider.notifier)
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
