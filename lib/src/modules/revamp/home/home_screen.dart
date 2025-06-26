import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/pos_device/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_home_screen.dart';
import 'package:rex_app/src/modules/revamp/home/home_screen_card.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarHomeScreen(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: .85,
          ),
          children: [
            HomeScreenCard(
              onTap: () {},
              label: 'Quick\nPurchase',
              icon: Icons.credit_card,
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'Quick\nTransfer',
              icon: Icons.send_rounded,
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'Transaction\nHistory',
              icon: Icons.receipt_long,
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'EOD Report\nPrinting',
              icon: Icons.print_rounded,
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'Transaction\nDisputes',
              icon: Icons.chat_bubble_outline,
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () async {
                print("DOWNLOAD SETTINGS HAVE BEEN TAPPED");
                ref.read(posGlobalProvider.notifier).doKeyExchange();
              },
              label: 'Download\nSettings',
              icon: Icons.download_rounded,
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
          ],
        ),
      ),
    );
  }
}
