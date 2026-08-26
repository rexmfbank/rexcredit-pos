// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/home/widget/home_screen_card.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_home_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/extension_on_snackbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(posGlobalProvider.notifier).globalInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    ref.listen(posGlobalProvider, (prev, next) {
      if (!context.mounted) return;
      if (next.message.isNotEmpty) {
        if (next.message == 'inactive') {
          context.push(Routes.inactiveScreen);
        } else if (next.message == 'update') {
          context.push(Routes.forceUpdateScreen);
        } else {
          context.showSnack(message: next.message, duration: snackDuration);
        }
        ref.read(posGlobalProvider.notifier).resetMessage();
      }
    });
    //
    return AppScaffold(
      isLoading: ref.watch(posGlobalProvider).isLoading,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexBackground,
      appBar: AppbarHomeScreen(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.quickPurchaseOption),
                        label: 'Card\nPurchase',
                        bgColor: Color(0xffEFF3FF),
                        iconPath: AssetPath.iconPurchase,
                      ),
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.quickTransferScreen),
                        label: 'Pay with\nTransfer',
                        bgColor: Color(0xffEBFAFC),
                        iconPath: AssetPath.iconTransfer,
                      ),
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.quickTransactions),
                        label: 'Transaction\nHistory',
                        bgColor: Color(0xffFFF7EB),
                        iconPath: AssetPath.iconHistory,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.eodOutsideScreen),
                        label: 'End of Day\nReport',
                        bgColor: Color(0xffFFF7EB),
                        iconPath: AssetPath.iconReport,
                      ),
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.fetchDispute),
                        label: 'Check\nDisputes',
                        bgColor: Color(0xffEFF3FF),
                        iconPath: AssetPath.iconDispute,
                      ),
                      HomeScreenCard(
                        onTap: () async {
                          ref
                              .read(posGlobalProvider.notifier)
                              .doKeyExchange(forceAuth: true);
                        },
                        label: 'Download\nKeys',
                        bgColor: Color(0xffEBFAFC),
                        iconPath: AssetPath.iconDownload,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Spacer(),
            SafeArea(
              child: RexElevatedButton(
                onPressed: () => _navCheck(Routes.login),
                buttonTitle: 'Login',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navCheck(String route) {
    final config = AppKeysStorage.getConfig();
    debugPrintDev("config on navcheck: ${config.toString()}");
    if (config.isDeviceActive == 'inactive') {
      context.push(Routes.inactiveScreen);
    } else if (config.isAppUpdated == 'false') {
      context.push(Routes.forceUpdateScreen);
    } else if (config.navCheck) {
      context.showSnack(message: Strings.downloadSetting);
    } else {
      context.push(route);
    }
  }
}
