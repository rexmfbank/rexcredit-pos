import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/fixed_deposit_webview.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessFixedDepositWebview extends ConsumerWidget {
  const BusinessFixedDepositWebview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: StringAssets.addCard,
        subtitle: '',
      ),
      body: FixedDepositWebview(),
    );
  }
}
