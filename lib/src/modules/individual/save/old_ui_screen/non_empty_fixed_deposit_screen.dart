import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/regular_savings_balance_card.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/regular_savings_transaction_card_item.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_tabbar.dart';

class NonEmptyFixedDepositSavingsScreen extends StatefulHookConsumerWidget {
  const NonEmptyFixedDepositSavingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NonEmptyFixedDepositSavingsScreenState();
}

class _NonEmptyFixedDepositSavingsScreenState
    extends ConsumerState<NonEmptyFixedDepositSavingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Savings', 'Withdrawal'];
  final List<SavingsTransactionData> data = [];

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
