import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_tabbar.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/tab_savings_list.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/tab_savings_withdrawals.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/target_savings_balance_card.dart';

class TargetSavingsNonEmpty extends StatefulHookConsumerWidget {
  const TargetSavingsNonEmpty({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualTargetSavingsNonEmptyState();
}

class _IndividualTargetSavingsNonEmptyState
    extends ConsumerState<TargetSavingsNonEmpty>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = ['Savings', 'Withdrawal'];

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2, vsync: this);
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TargetSavingsBalanceCard(),
          SaveTabBar(tabController: tabController, tabs: _tabs),
          const SizedBox(height: 16),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: const [
                TabSavingsList(),
                TabSavingsWithdrawals(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
