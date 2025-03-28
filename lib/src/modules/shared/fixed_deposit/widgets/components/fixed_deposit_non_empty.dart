import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/save_tabbar.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/tab_fixed_deposit_list.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/tab_fixed_deposit_withdrawal.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/fixed_deposit_balance_card.dart';

class FixedDepositNonEmpty extends StatefulHookConsumerWidget {
  const FixedDepositNonEmpty({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualFixedDepositNonEmptyState();
}

class _IndividualFixedDepositNonEmptyState
    extends ConsumerState<FixedDepositNonEmpty>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = ['Fixed deposits', 'Withdrawal'];

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(
      initialLength: _tabs.length,
      vsync: this,
    );
    //
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          const FixedDepositBalanceCard(),
          SaveTabBar(tabController: tabController, tabs: _tabs),
          const SizedBox(height: 16),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: const [
                TabFixedDepositTabList(),
                TabFixedDepositWithdrawal(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
