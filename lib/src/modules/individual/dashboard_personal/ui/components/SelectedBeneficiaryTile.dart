import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SelectedBeneficiaryTile extends ConsumerWidget{
  const SelectedBeneficiaryTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.aw),
      padding: EdgeInsets.all(12.ar),
      decoration: BoxDecoration(
        color: AppColors.rexLightBlue,
        borderRadius: BorderRadius.circular(12.ar),
        border: Border.all(
          color: AppColors.rexLightBlue2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ref.watch(homeTransferNotifier).selectedBeneficiary?.beneficiaryName ?? 'N/a',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.asp,
              color: Colors.black, // You can change the color
            ),
          ),
          SizedBox(height: 8.ah),
          Text(
            ref.watch(homeTransferNotifier).selectedBeneficiary?.finEntityName ??  StringAssets.bank,
            style: TextStyle(
              fontSize: 14.asp,
              color: AppColors.cardGrey,
            ),
          ),
          SizedBox(height: 4.ah),
          Text(
            ref.watch(homeTransferNotifier).selectedBeneficiary?.beneficiaryAccount ?? 'N/a',
            style: TextStyle(
              fontSize: 14.asp,
              color: AppColors.cardGrey,
            ),
          ),
        ],
      ),
    );
  }

}