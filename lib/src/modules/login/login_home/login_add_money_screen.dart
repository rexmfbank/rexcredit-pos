import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/pos_list_tile.dart';

class LoginAddMoneyScreen extends ConsumerWidget {
  const LoginAddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = AppKeysStorage.getConfig();
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      appBar: AppbarSubScreen(title: 'Bank Transfer', centerTitle: true),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.rexWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CopyAcct(),
                  Divider(),
                  PosListTile(
                    title: 'Bank Name',
                    subtitle: 'Rex MFB',
                    onTap: null,
                    iconPath: AssetPath.iconCardPurchase,
                    iconBgColor: Color(0xffEFF3FF),
                    contentPadding: EdgeInsetsGeometry.zero,
                    titleTextStyle: AppTextStyles.body6Regular,
                    subtitleTextStyle: AppTextStyles.body5Regular,
                  ),
                  PosListTile(
                    title: 'Account Name',
                    subtitle: config.baasNubanName,
                    onTap: null,
                    iconPath: AssetPath.iconName,
                    iconBgColor: Color(0xffFFF7EB),
                    contentPadding: EdgeInsetsGeometry.zero,
                    titleTextStyle: AppTextStyles.body6Regular,
                    subtitleTextStyle: AppTextStyles.body5Regular,
                  ),
                  PosListTile(
                    title: 'Rex Account Number',
                    subtitle: config.baasNuban,
                    onTap: null,
                    iconPath: AssetPath.iconWallet,
                    iconBgColor: Color(0xffEFF3FF),
                    contentPadding: EdgeInsetsGeometry.zero,
                    titleTextStyle: AppTextStyles.body6Regular,
                    subtitleTextStyle: AppTextStyles.body5Regular,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class CopyAcct extends StatelessWidget {
  const CopyAcct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bank Account Details',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff2E3D60),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffE4EBFC),
            ),
            child: Padding(padding: EdgeInsets.all(8), child: Text('Copy')),
          ),
        ],
      ),
    );
  }
}
