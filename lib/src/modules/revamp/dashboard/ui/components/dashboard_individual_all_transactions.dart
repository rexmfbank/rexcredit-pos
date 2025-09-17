import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui_widgets/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardIndividualAllTransactions extends ConsumerWidget {
  const DashboardIndividualAllTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.allTransactions,
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
                    // showTransactionFilterModal(context);
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
        ],
      ),
    );
  }
}
