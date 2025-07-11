import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SaveTransferBeneficiarySwitch extends ConsumerWidget {
  const SaveTransferBeneficiarySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: 16.aw),
      child: Row(
        children: [
          Text(
            StringAssets.saveBeneficiary,
            style: AppTextStyles.body3Regular,
          ),
          Transform.scale(
            scaleX: 0.7,
            scaleY: 0.6, // Adjust the scale factor to make the switch smaller
            child: Switch.adaptive(
              value: ref.watch(homeTransferNotifier).saveBeneficiary,
              onChanged: (bool value) => ref
                  .watch(homeTransferNotifier.notifier)
                  .toggleSaveBeneficiary(),
            ),
          )
        ],
      ),
    );
  }
}
