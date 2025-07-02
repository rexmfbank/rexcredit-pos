import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/regular_savings_balance_card.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/regular_savings_transaction_card_item.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_tabbar.dart';

class NonEmptyRegularSavingsScreen extends StatefulHookConsumerWidget {
  const NonEmptyRegularSavingsScreen({Key? key}) : super(key: key);

  @override
  _NonEmptyRegularSavingsScreenState createState() =>
      _NonEmptyRegularSavingsScreenState();
}

class _NonEmptyRegularSavingsScreenState
    extends ConsumerState<NonEmptyRegularSavingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Savings', 'Withdrawal'];
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          const RegularSavingsBalanceCard(),
          SaveTabBar(tabController: _tabController, tabs: _tabs),
          const SizedBox(height: 16),
          Flexible(
            child: TabBarView(
              controller: _tabController, // Set the TabController
              children: [
                _buildAllSavingsTransactionList(context),
                _buildSavingsList(context),
                _buildWithdrawalList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllSavingsTransactionList(BuildContext context) {
    // final allTargetSavings = ref.watch(fetchSavingsPlansProvider);

    // return allTargetSavings.when(
    //     data: (data) {
    //       return ListView.builder(
    //         itemCount: data.length,
    //         itemBuilder: (context, index) {
    //           return SavingsCardItem(
    //             data: data[index],
    //           );
    //         },
    //       );
    //     },
    //     error: (obj, stack) => const Center(
    //           child: Text(
    //             "An error occured!",
    //             style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
    //           ),
    //         ),
    //     loading: () {
    //       return CircularProgressIndicator(
    //         color: AppColors.rexPurpleDark,
    //       );
    //     });

    return Container(
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
    );
  }

  Widget _buildWithdrawalList(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildSavingsList(BuildContext context) {
    return Container(
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
    );
  }
}
