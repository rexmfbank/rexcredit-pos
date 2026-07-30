import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/disputes/widgets/fetch_dispute_card.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';

class TransactionFetchDisputeScreen2 extends ConsumerStatefulWidget {
  const TransactionFetchDisputeScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionFetchDisputeScreen2State();
}

class _TransactionFetchDisputeScreen2State
    extends ConsumerState<TransactionFetchDisputeScreen2> {
  @override
  Widget build(BuildContext context) {
    final disputes = ref.watch(posFetchDisputeProvider);
    return AppScaffold(
      appBar: AppbarSubScreen(title: "Transaction Disputes", centerTitle: true),
      body: disputes.when(
        data: (data) {
          if (data.isEmpty) {
            return const _NoDisputeWidget();
          }
          // Sort by date descending (most recent first)
          final sortedData = [...data]..sort((a, b) {
            final dateA = a.createdAtDate;
            final dateB = b.createdAtDate;
            if (dateA == null || dateB == null) return 0;
            return dateB.compareTo(dateA);
          });
          return ListView.builder(
            itemCount: sortedData.length,
            itemBuilder: (context, index) {
              return FetchDisputeCard(dispute: sortedData[index]);
            },
          );
        },
        loading:
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircularProgressIndicator(),
                  title: Text('Loading Disputes'),
                ),
              ],
            ),
        error: (error, stackTrace) => const _DisputeError(),
      ),
    );
  }
}

class _DisputeError extends StatelessWidget {
  const _DisputeError();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text('Apologies'),
          subtitle: Text('Unable to get the data on disputes.'),
        ),
      ],
    );
  }
}

class _NoDisputeWidget extends StatelessWidget {
  const _NoDisputeWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(AssetPath.iconView),
          title: const Text('No disputes'),
          subtitle: const Text('List is empty.'),
        ),
      ],
    );
  }
}
