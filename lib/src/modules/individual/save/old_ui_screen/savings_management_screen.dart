import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/add_recurring_card_dialog.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_due_date_item.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_interest_info_card.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_management_appbar.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_management_balance_card.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_management_next_savings_info_card.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_progress_widget.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/start_to_maturity_date_savings_card.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/double_utils.dart';

class SavingsManagementSavingsScreen extends HookConsumerWidget {
  const SavingsManagementSavingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingsDetail = AsyncValue.data('');
    final logger = ref.watch(loggerProvider);

    return savingsDetail.when(
      data: (data) {
        return Scaffold(
            appBar: SavingsManagementAppBar(
              hasBackButton: true,
              title: '',
              maturity: '',
              planId: 0,
              balance: '',
              maturityDate: '',
            ),
            body: ListView(
              children: [
                SavingsManagementBalanceCard(
                  balance: '',
                  targetAmount: '',
                ),
                SavingsProgressWidget(
                  percentage: parseDouble('0.00'),
                ),
                SavingsInterestInfoCard(
                  interestAccrued: '',
                ),
                StartToMaturityDateSavingsCard(
                  startDate: '',
                  maturityDate: '',
                ),
                NextPaymentCardLayout(
                  nextExpectedDate: '',
                  nextExpectedInDays: '',
                  autoSave: false,
                  onAutosaveToggle: (value) {
                    showRecurringCardModalSheet(context: context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: SizedBox(
                    height: 105, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SaveDateListItem(paymentDateData: ''),
                        );
                      },
                    ),
                  ),
                ),
                // data.transactions != null
                //     ? Padding(
                //         padding: const EdgeInsets.only(top: 8),
                //         child: Container(
                //           margin: const EdgeInsets.all(15.0),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20.0),
                //             color: Colors.white,
                //           ),
                //           height: 250,
                //           child: data.transactions != null
                //               ? ListView.builder(
                //                   itemCount: data.transactions!
                //                       .length, // data.transactions!.length
                //                   itemBuilder: (context, index) {
                //                     return Padding(
                //                       padding: const EdgeInsets.only(
                //                           right: 8.0, left: 8.0),
                //                       child: TransactionOverviewListItem(
                //                         transactionData:
                //                             data.transactions![index],
                //                       ),
                //                     );
                //                   },
                //                 )
                //               : Container(),
                //         ),
                //       )
                //     : Container(),
              ],
            ));
      },
      error: (Object error, StackTrace stackTrace) => const Scaffold(
        appBar: RexAppBar(
            step: null,
            shouldHaveBackButton: true,
            title: 'Savings',
            subtitle: ""),
        body: Center(
          child: Text(
            "An error occured!",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
      ),
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
