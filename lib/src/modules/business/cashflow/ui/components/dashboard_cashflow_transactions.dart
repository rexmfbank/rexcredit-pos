import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/regular_savings_transaction_card_item.dart';

class DashboardCashflowTransactions extends HookConsumerWidget {
  const DashboardCashflowTransactions({super.key});
  final bool isProfileCompleted = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return GestureDetector(
      onTap: () {
        context.push(
            '${RouteName.dashboardBusiness}/${RouteName.cashflowTransactions}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return RegularSavingsTransactionCardItem(
              data: data[index],
            );
          },
        ),
      ),
    );
  }
}
