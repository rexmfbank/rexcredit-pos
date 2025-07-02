import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_confirm_pin_modal_sheet.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/widgets/show_modal_choose_payment_method.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class BillPaymentEducationConfirmScreen extends ConsumerWidget {
  const BillPaymentEducationConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: null,
        title: 'Confirm Transcation',
        subtitle: 'Review your transaction details',
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            color: AppColors.rexWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(
                  title: Text('Biller'),
                  subtitle: Text('Afe Babalola University'),
                ),
                Divider(),
                ListTile(
                  title: Text('Plan'),
                  subtitle: Text('Accounting - 200L'),
                ),
                Divider(),
                ListTile(
                  title: Text('Beneficiary name'),
                  subtitle: Text('Alexander A.'),
                ),
                Divider(),
                ListTile(
                  title: Text('Amount'),
                  subtitle: Text('100,000'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RexElevatedButton(
              onPressed: () {
                // showModalChoosePayment(
                //   context: context,
                //   onPressed: () {
                //     context.pop();
                //     showTransferPinModalSheet(
                //       context: context,
                //       onPinEntered: (value) {
                //         context.pop();
                //         showModalAction(
                //           context: context,
                //           dialogTitle: 'School Fee Payment successful',
                //           dialogSubtitle: 'You have successfully subscribed',
                //           onPressed: () {
                //             context.go(RouteName.dashboardSpend);
                //           },
                //         );
                //       },
                //     );
                //   },
                // );
              },
              buttonTitle: 'Make Payment',
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
