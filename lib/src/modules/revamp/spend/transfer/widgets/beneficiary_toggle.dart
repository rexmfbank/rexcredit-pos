import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_transfer_notifier.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_icon_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BeneficiaryToggle extends ConsumerWidget {
  final Function() onPressed;
  const BeneficiaryToggle({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12.ah,
        bottom: 12.ah,
      ),
      child: CustomIconButton(
        onPressed: onPressed,
        title: !ref.read(internalTransferNotifier).isSendToBeneficiary
            ? StringAssets.sendToNewBeneficiaryTitle
            : StringAssets.selectBeneficiary,
        backgroundColor: AppColors.rexPurpleLight,
        textColor: Colors.white,
        iconPath: AssetPath.addBeneficiary,
      ),
    );
  }
}
