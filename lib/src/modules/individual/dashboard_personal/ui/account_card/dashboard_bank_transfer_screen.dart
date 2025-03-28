import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/dashboard_bank_account_details.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardBankTransferScreen extends ConsumerWidget {
  const DashboardBankTransferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        showProfileImage: false,
        shouldHaveBackButton: true,
        title: StringAssets.bankTransferTitle,
        subtitle: StringAssets.bankTransferSubtitle,
        onBackButtonPressed: () => context.pop(),
      ),
      body: const DashboardBankAccountDetails(),
    );
  }
}
