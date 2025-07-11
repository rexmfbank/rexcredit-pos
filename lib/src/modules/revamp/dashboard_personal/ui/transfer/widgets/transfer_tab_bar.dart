import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TransferTabBar extends ConsumerWidget {
  const TransferTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.aw),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16.ar),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.ar),
        child: TabBar(
          physics: const NeverScrollableScrollPhysics(),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(16.ar),
            color: Colors.white,
          ),
          indicatorWeight: 1.0,
          labelStyle: AppTextStyles.body2Regular.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 11.asp,
          ),
          labelColor: AppColors.rexPurpleDark,
          unselectedLabelColor: Colors.grey,
          controller: ref.watch(homeTransferNotifier).transferTabController,
          tabs: const [
            Tab(text: StringAssets.otherBanks),
            Tab(text: StringAssets.toRex),
          ],
        ),
      ),
    );
  }
}
