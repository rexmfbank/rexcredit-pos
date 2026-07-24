import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/pos_list_tile.dart';

class LoginAddMoneyScreen extends ConsumerWidget {
  const LoginAddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      appBar: AppbarSubScreen(title: 'Bank Transfer'),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.rexWhite,
        ),
        child: Column(
          children: [
            PosListTile(
              title: 'Bank Name',
              subtitle: 'Rex MFB',
              onTap: null,
              iconPath: AssetPath.iconCardPurchase,
              iconBgColor: Color(0xffEFF3FF),
            ),
            PosListTile(
              title: 'Account Name',
              subtitle: 'JOHN DOE POS 1',
              onTap: null,
              iconPath: AssetPath.iconCardPurchase,
              iconBgColor: Color(0xffEFF3FF),
            ),
            PosListTile(
              title: 'Rex Account Number',
              subtitle: '0123456789',
              onTap: null,
              iconPath: AssetPath.iconCardPurchase,
              iconBgColor: Color(0xffEFF3FF),
            ),
          ],
        ),
      ),
    );
  }
}
