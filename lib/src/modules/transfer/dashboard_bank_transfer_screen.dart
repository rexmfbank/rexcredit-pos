import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class DashboardBankTransferScreen extends ConsumerWidget {
  const DashboardBankTransferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        showProfileImage: false,
        shouldHaveBackButton: true,
        title: Strings.bankTransferTitle,
        subtitle: Strings.bankTransferSubtitle,
        onBackButtonPressed: () => context.pop(),
      ),
      body: const DashboardBankAccountDetails(),
    );
  }
}

class DashboardBankAccountDetails extends ConsumerWidget {
  const DashboardBankAccountDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = AppKeysStorage.getConfig().loginFullname;
    final acctNo = AppKeysStorage.getConfig().loginNuban;
    //
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.aw),
          child: Card(
            margin: EdgeInsets.all(8.ar),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.ar)),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.ar),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Image.asset(AssetPath.bankTransferIcon1),
                    title: const Text('Bank', style: _titleText),
                    subtitle: const Text('Rex MFB', style: _subtitleText),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(AssetPath.bankTransferIcon2),
                    title: const Text('Name', style: _titleText),
                    subtitle: Text(name, style: _subtitleText),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(AssetPath.bankTransferIcon3),
                    title: const Text('Rex Account Number', style: _titleText),
                    subtitle: Text(acctNo, style: _subtitleText),
                    trailing: IconButton(
                      onPressed: () async {
                        Clipboard.setData(ClipboardData(text: acctNo));
                      },
                      icon: Image.asset(AssetPath.bankTransferIcon4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// text style for text
const _titleText = TextStyle(
  color: AppColors.grey,
  fontWeight: FontWeight.w500,
);

const _subtitleText = TextStyle(color: AppColors.rexPurpleDark, fontSize: 16);
