import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_home_screen.dart';
import 'package:rex_app/src/modules/revamp/home/home_screen_card.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

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
      ref.read(posGlobalProvider.notifier).checkBaseAppInstalled();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsDone = ref.watch(settingsDoneProvider);
    return AppScaffold(
      isLoading: ref.watch(posGlobalProvider).isLoading,
      padding: EdgeInsets.all(0),
      // resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarHomeScreen(),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
              onTap: () {
                if (!settingsDone) {
                  context.showToastForFalseSettings();
                } else {
                  context.push(Routes.quickPurchaseScreen);
                }
              },
              label: 'Quick\nPurchase',
              icon: SvgPicture.asset('assets/svg/quick-purchase-icon.svg'),
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {
                if (!settingsDone) {
                  context.showToastForFalseSettings();
                } else {
                  context.push(Routes.quickTransferScreen);
                }
              },
              label: 'Quick\nTransfer',
              icon: SvgPicture.asset('assets/svg/quick-transfer-icon.svg'),
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {
                if (!settingsDone) {
                  context.showToastForFalseSettings();
                } else {
                  context.push(Routes.transactionHistory);
                }
              },
              label: 'Transaction\nHistory',
              icon: SvgPicture.asset('assets/svg/trans-history-icon.svg'),
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {},
              label: 'EOD Report\nPrinting',
              icon: SvgPicture.asset('assets/svg/eod-print-icon.svg'),
              textStyle: AppTextStyles.homeCardTheme(context),
            ),
            HomeScreenCard(
              onTap: () {},
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
    );
  }
}
