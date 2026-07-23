import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/home/widget/home_screen_card.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';

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
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeScreenCard(
              onTap: () {},
              label: 'Purchase',
              bgColor: Color(0xffEFF3FF),
              iconPath: AssetPath.iconPurchase,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'Receipt',
              bgColor: Color(0xffEBFAFC),
              iconPath: AssetPath.iconTransfer,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'History',
              bgColor: Color(0xffFFF7EB),
              iconPath: AssetPath.iconHistory,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeScreenCard(
              onTap: () {},
              label: 'Notifications',
              bgColor: Color(0xffFFF7EB),
              iconPath: AssetPath.iconReport,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'Profile',
              bgColor: Color(0xffEFF3FF),
              iconPath: AssetPath.iconDispute,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'Legal',
              bgColor: Color(0xffEBFAFC),
              iconPath: AssetPath.iconDownload,
              textStyle: AppTextStyles.homeCardTheme2(context),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
