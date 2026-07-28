import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/container_style_button.dart';
import 'package:rex_app/src/modules/utils/widgets/pos_list_tile.dart';

class LoginSettingsScreen extends ConsumerWidget {
  const LoginSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexBackground,
      appBar: AppbarSubScreen(title: 'Settings', centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.rexWhite),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text('PROFILE SETTINGS', style: AppTextStyles.h8),
            PosListTile(
              title: 'Personal Information',
              subtitle: 'Manage your account profile',
              onTap: () => context.push(Routes.profilePath),
              iconPath: AssetPath.iconPersonInfo,
              iconBgColor: Color(0xffEBFAFC),
              contentPadding: EdgeInsetsGeometry.zero,
            ),
            Divider(),
            Text('SECURITY SETTINGS', style: AppTextStyles.h8),
            PosListTile(
              title: 'Change Password',
              subtitle: 'Set a new password',
              onTap: () {},
              iconPath: AssetPath.iconChangePass,
              iconBgColor: Color(0xffFFF7EB),
              contentPadding: EdgeInsetsGeometry.zero,
            ),
            PosListTile(
              title: 'Key Exchange',
              subtitle: 'Do a key exchange process',
              onTap:
                  () => ref
                      .read(posGlobalProvider.notifier)
                      .doKeyExchange(context: context),
              iconPath: AssetPath.iconChangeQues,
              iconBgColor: Color(0xffEFF3FF),
              contentPadding: EdgeInsetsGeometry.zero,
            ),
            Divider(),
            Text('SUPPORT OR LEGAL', style: AppTextStyles.h8),
            PosListTile(
              title: 'Legal',
              subtitle: 'Our terms and conditions & privacy policy',
              onTap: () {},
              iconPath: AssetPath.iconLegal,
              iconBgColor: Color(0xffEBFAFC),
              contentPadding: EdgeInsetsGeometry.zero,
            ),
            Divider(),
            ContainerStyleButton(
              title: 'Logout',
              bgColor: AppColors.redDark,
              textColor: AppColors.rexWhite,
              onTap: () => context.go(Routes.homeScreen),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
