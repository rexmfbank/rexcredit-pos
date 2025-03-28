import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/dashboard_savings_appbar.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_tabbar.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/fixed_deposit_screen_body.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/target_saving_screen_body.dart';

class DashboardSaveBusiness extends StatefulHookConsumerWidget {
  const DashboardSaveBusiness({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardSaveBusinessState();
}

class _DashboardSaveBusinessState extends ConsumerState<DashboardSaveBusiness>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = ['Target Savings', 'Fixed Deposits'];

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2, vsync: this);
    return Scaffold(
      appBar: const DashboardSavingsAppBar(),
      body: DefaultTabController(
        length: 2,
        child: Column(children: [
          SaveTabBar(tabController: tabController, tabs: _tabs),
          const SizedBox(height: 16),
          Flexible(
            child: TabBarView(
              controller: tabController, // Set the TabController
              children: const [
                TargetSavingScreenBody(),
                FixedDepositScreenBody(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
