import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';

class QuickPurchaseOptionScreen extends ConsumerWidget {
  const QuickPurchaseOptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      appBar: AppbarSubScreen(title: 'Select Action'),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(12),
              leading: SvgPicture.asset('assets/svg/quick-purchase-icon.svg'),
              title: Text(
                'Card Purchase',
                style: AppTextStyles.homeCardTheme(context),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFF0E234A),
              ),
              onTap: () {
                ref.read(posCardPurchaseProvider.notifier).initializeData();
                context.push(Routes.quickPurchaseScreen);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(12),
              leading: SvgPicture.asset('assets/svg/quick-purchase-icon.svg'),
              title: Text(
                'Check Card Balance',
                style: AppTextStyles.homeCardTheme(context),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFF0E234A),
              ),
              onTap: () {
                ref.read(posCardPurchaseProvider.notifier).doCheckBalance();
              },
            ),
          ],
        ),
      ),
    );
  }
}
