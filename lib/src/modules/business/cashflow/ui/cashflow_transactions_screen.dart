import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/show_transaction_filter_modal.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/regular_savings_transaction_card_item.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class CashflowTransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<SavingsTransactionData> data = [
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings withdrawal",
        status: "pending",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "failed",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings top up",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
      SavingsTransactionData(
        transactionType: "Savings withdrawal",
        status: "successful",
        date: "2023-06-01",
        amount: "20,000",
      ),
    ];

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Transactions',
        subtitle: '',
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: TransferBeneficiarySearchBar(),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    showTransactionFilterModal(context);
                  },
                  child: Image.asset(
                    'assets/png/filter_icon.png',
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return RegularSavingsTransactionCardItem(
                data: data[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
