import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/rex_savings_balance_card.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_dashboard_tabbar.dart';
import 'package:rex_app/src/utils/currency.dart';

class NonEmptyStateSavingsScreen extends StatefulHookConsumerWidget {
  const NonEmptyStateSavingsScreen({Key? key}) : super(key: key);

  @override
  _NonEmptyStateSavingsScreen createState() => _NonEmptyStateSavingsScreen();
}

class _NonEmptyStateSavingsScreen
    extends ConsumerState<NonEmptyStateSavingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Active', 'Pending', 'Completed'];

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
          RexSavingsBalanceCard(
            total: addNairaCurrencySymbol('67,000'),
            onIconTap: () {},
          ),
          SavingsDashboardTabBar(tabController: _tabController, tabs: _tabs),
          const SizedBox(height: 16),
          Flexible(
            child: TabBarView(
              controller: _tabController, // Set the TabController
              children: [
                _buildAllSavingsList(context),
                _buildActiveSavingsList(context),
                _buildPendingSavingsList(context),
                _buildCompletedSavingsList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllSavingsList(BuildContext context) {
    return Container();
  }

  Widget _buildPendingSavingsList(BuildContext context) {
    return Container();
  }

  Widget _buildActiveSavingsList(BuildContext context) {
    return Container();
  }

  Widget _buildCompletedSavingsList(BuildContext context) {
    return Container();
  }
}
