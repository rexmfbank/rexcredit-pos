import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/home/widget/home_screen_card.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

class LoginHomeActions extends ConsumerStatefulWidget {
  const LoginHomeActions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginHomeActionsState();
}

class _LoginHomeActionsState extends ConsumerState<LoginHomeActions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 4),
            HomeScreenCard(
              onTap: () {},
              label: 'Purchase',
              bgColor: Color(0xffEFF3FF),
              iconPath: AssetPath.iconPurchase,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            SizedBox(width: 4),
            HomeScreenCard(
              onTap: () {},
              label: 'Receipt',
              bgColor: Color(0xffEBFAFC),
              iconPath: AssetPath.iconTransfer,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            SizedBox(width: 4),
            HomeScreenCard(
              onTap: () => context.push(Routes.loginTransHistoryPath),
              label: 'History',
              bgColor: Color(0xffFFF7EB),
              iconPath: AssetPath.iconHistory,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            SizedBox(width: 4),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 4),
            HomeScreenCard(
              onTap: () {},
              label: 'Notifications',
              bgColor: Color(0xffFFF7EB),
              iconPath: AssetPath.iconReport,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            SizedBox(width: 4),
            HomeScreenCard(
              onTap: () => context.push(Routes.profilePath),
              label: 'Profile',
              bgColor: Color(0xffEFF3FF),
              iconPath: AssetPath.iconDispute,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            SizedBox(width: 4),
            HomeScreenCard(
              onTap: () => context.push(Routes.loginSettingsPath),
              label: 'Settings',
              bgColor: Color(0xffEBFAFC),
              iconPath: AssetPath.iconDownload,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            SizedBox(width: 4),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
