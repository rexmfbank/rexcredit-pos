import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/models/transaction_query_payload.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/container_style_button.dart';

class QuickTransactionsFetchStatus extends ConsumerStatefulWidget {
  const QuickTransactionsFetchStatus({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransactionsFetchStatusState();
}

class _QuickTransactionsFetchStatusState
    extends ConsumerState<QuickTransactionsFetchStatus> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fetchStatusOutsideProvider(''));
    return AppScaffold(
      body: state.when(
        data: (data) => FetchPosQuerySummary(data: data),
        error:
            (_, _) => Center(
              child: Column(
                children: [
                  Text(''),
                  ContainerStyleButton(
                    title: 'Back Home',
                    bgColor: Color(0xffE8EEFF),
                    textColor: Color(0xff002766),
                    onTap: () => context.go(Routes.homeScreen),
                  ),
                ],
              ),
            ),
        loading: () => Center(child: CupertinoActivityIndicator(radius: 20)),
      ),
    );
  }
}

class FetchPosQuerySummary extends ConsumerWidget {
  const FetchPosQuerySummary({super.key, required this.data});

  final TransactionQueryResponse data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
