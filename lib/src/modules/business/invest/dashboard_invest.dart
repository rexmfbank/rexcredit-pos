import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/dashboard_savings_appbar.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_tabbar.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_screen/investments_screen.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_screen/regular_savings_screen.dart';

class DashboardSaveScreen extends StatefulHookConsumerWidget {
  const DashboardSaveScreen({super.key});

  _DashboardSaveScreen createState() => _DashboardSaveScreen();
}

class _DashboardSaveScreen extends ConsumerState<DashboardSaveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Regular Savings', 'Investments'];

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
    return Scaffold(
      appBar: const DashboardSavingsAppBar(),
      body: DefaultTabController(
        length: _tabs.length,
        child: Column(children: [
          SaveTabBar(tabController: _tabController, tabs: _tabs),
          const SizedBox(height: 16),
          Flexible(
            child: TabBarView(
              controller: _tabController, // Set the TabController
              children: [
                RegularSavingsScreen(),
                InvestmentsScreen(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
