// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/home/widget/app_version_text.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_home_screen.dart';
import 'package:rex_app/src/modules/home/widget/home_screen_card.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref.read(posGlobalProvider.notifier).checkBaseAppInstalled(context);
    });
  }

  Future<void> _navigateOnCheck(String route) async {
    final config = AppKeysStorage.getConfig();
    //
    if (config.isAuthFailed == 'true') {
      context.showSnack(message: Strings.downloadSetting);
    } else if (config.isExchangeDone.isEmpty) {
      context.showSnack(message: Strings.downloadSetting);
    } else if (config.serialNumber.isEmpty) {
      context.showSnack(message: Strings.downloadSetting);
    } else {
      context.push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(posGlobalProvider).isLoading,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexBackground,
      appBar: AppbarHomeScreen(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 12,
                  childAspectRatio: .85,
                ),
                children: [
                  HomeScreenCard(
                    onTap: () => _navigateOnCheck(Routes.quickPurchaseOption),
                    // onTap: () {
                    //   ref
                    //       .read(posCardPurchaseProvider.notifier)
                    //       .initializeData();
                    //   _navigateOnCheck(Routes.quickPurchaseScreen);
                    // },
                    label: 'Quick\nPurchase',
                    icon: SvgPicture.asset(
                      'assets/svg/quick-purchase-icon.svg',
                    ),
                    textStyle: AppTextStyles.homeCardTheme(context),
                  ),
                  HomeScreenCard(
                    onTap: () => _navigateOnCheck(Routes.quickTransferScreen),
                    label: 'Pay with\nTransfer',
                    icon: SvgPicture.asset(
                      'assets/svg/quick-transfer-icon.svg',
                    ),
                    textStyle: AppTextStyles.homeCardTheme(context),
                  ),
                  HomeScreenCard(
                    onTap: () => _navigateOnCheck(Routes.quickTransactions),
                    label: 'Transaction\nHistory',
                    icon: SvgPicture.asset('assets/svg/trans-history-icon.svg'),
                    textStyle: AppTextStyles.homeCardTheme(context),
                  ),
                  HomeScreenCard(
                    onTap: () => _navigateOnCheck(Routes.eodOutsideScreen),
                    label: 'EOD Report\nPrinting',
                    icon: SvgPicture.asset('assets/svg/eod-print-icon.svg'),
                    textStyle: AppTextStyles.homeCardTheme(context),
                  ),
                  HomeScreenCard(
                    onTap: () => context.push(Routes.fetchDispute),
                    label: 'Transaction\nDisputes',
                    icon: SvgPicture.asset('assets/svg/trans-dispute-icon.svg'),
                    textStyle: AppTextStyles.homeCardTheme(context),
                  ),
                  HomeScreenCard(
                    onTap: () async {
                      ref
                          .read(posGlobalProvider.notifier)
                          .doKeyExchange(context: context);
                    },
                    label: 'Download\nSettings',
                    icon: SvgPicture.asset('assets/svg/setting-icon.svg'),
                    textStyle: AppTextStyles.homeCardTheme(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SafeArea(top: false, child: AppVersionText()),
          ],
        ),
      ),
    );
  }
}
