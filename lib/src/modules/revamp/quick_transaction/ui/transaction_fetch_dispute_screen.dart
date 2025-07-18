import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/disputes/widgets/fetch_dispute_card.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class TransactionFetchDisputeScreen extends ConsumerStatefulWidget {
  const TransactionFetchDisputeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionFetchDisputeScreenState();
}

class _TransactionFetchDisputeScreenState
    extends ConsumerState<TransactionFetchDisputeScreen> {
  @override
  Widget build(BuildContext context) {
    final disputes = ref.watch(fetchDisputesProvider);
    return AppScaffold(
      appBar: AppbarSubScreen(title: "Transaction Disputes"),
      body: disputes.when(
        data: (data) {
          if (data == null || data.isEmpty) {
            return const _NoDisputeWidget();
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final date = data[index].disputedDate;
              return FetchDisputeCard(
                status: data[index].status!,
                transactionId: data[index].transactionId!,
                message: data[index].disputeMessage!,
                date: "${date![0]}-${date[1]}-${date[2]}",
              );
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
