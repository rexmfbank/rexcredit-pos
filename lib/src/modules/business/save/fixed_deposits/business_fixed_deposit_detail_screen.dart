import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/deposit_item_detail_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessFixedDepositDetailScreen extends ConsumerWidget {
  const BusinessFixedDepositDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.fixedDepositDetailText,
      ),
      body: DepositItemDetailScreenBody(),
    );
  }
}
