import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/quick_transaction/pos_trans/pos_trans_detail_body.dart';
import 'package:rex_app/src/modules/quick_transaction/pos_trans/pos_trans_fetch_body.dart';
import 'package:rex_app/src/modules/quick_transaction/pos_trans/pos_trans_screen_body.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';

class LoginTransactionScreen extends ConsumerWidget {
  const LoginTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      appBar: AppbarSubScreen(title: 'Transaction History', centerTitle: true),
      body: PosTransactionsScreenBody(outside: false),
    );
  }
}

class LoginTransactionDetailScreen extends ConsumerWidget {
  const LoginTransactionDetailScreen({super.key, this.data});

  final PosTransactionsResponseData? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = data == null ? ref.watch(memoryPosTransProvider) : data!;
    return AppScaffold(
      appBar: AppbarSubScreen(title: 'Transaction Details', centerTitle: true),
      backgroundColor: AppColors.rexBackground,
      body: PosTransactionDetailBody(detail: detail, outside: false),
    );
  }
}

class LoginTransactionFetchStatus extends ConsumerWidget {
  const LoginTransactionFetchStatus({super.key, required this.transRef});

  final String transRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      body: PosTransactionFetchBody(transRef: transRef, outside: false),
    );
  }
}
