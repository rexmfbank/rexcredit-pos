import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/dashboard_savings_appbar.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_tabbar.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/fixed_deposit_screen_body.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/target_saving_screen_body.dart';

class DashboardIndividualSaveScreen extends StatefulHookConsumerWidget {
  final int? initPage;
  const DashboardIndividualSaveScreen({
    super.key,
    this.initPage,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardIndividualSaveScreenState();
}

class _DashboardIndividualSaveScreenState
    extends ConsumerState<DashboardIndividualSaveScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = ['Target Savings', 'Fixed Deposits'];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initPage ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardSavingsAppBar(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SaveTabBar(tabController: tabController, tabs: _tabs),
            const SizedBox(height: 10),
            Flexible(
              child: TabBarView(
                controller: tabController,
                children: const [
                  TargetSavingScreenBody(),
                  FixedDepositScreenBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
