import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class DashboardBankAccountDetails extends ConsumerWidget {
  const DashboardBankAccountDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userFullNameProvider);
    final acctNo = ref.watch(userNubanProvider);
    //
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.aw),
          child: Card(
            margin: EdgeInsets.all(8.ar),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.ar),
              ),
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
        )
      ],
    );
  }
}

// text style for text
const _titleText = TextStyle(
  color: AppColors.grey,
  fontWeight: FontWeight.w500,
);

const _subtitleText = TextStyle(
  color: AppColors.rexPurpleDark,
  fontSize: 16,
);
