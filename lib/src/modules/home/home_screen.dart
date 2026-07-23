// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/home/widget/home_screen_card.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_home_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';

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
      //ref.read(posGlobalProvider.notifier).checkBaseAppInstalled(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        label: 'Purchase',
                        bgColor: Color(0xffEFF3FF),
                        iconPath: AssetPath.iconPurchase,
                      ),
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.quickTransferScreen),
                        label: 'Transfer',
                        bgColor: Color(0xffEBFAFC),
                        iconPath: AssetPath.iconTransfer,
                      ),
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.quickTransactions),
                        label: 'History',
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
                        label: 'EOD Report',
                        bgColor: Color(0xffFFF7EB),
                        iconPath: AssetPath.iconReport,
                      ),
                      HomeScreenCard(
                        onTap: () => _navCheck(Routes.fetchDispute),
                        label: 'Disputes',
                        bgColor: Color(0xffEFF3FF),
                        iconPath: AssetPath.iconDispute,
                      ),
                      HomeScreenCard(
                        onTap: () async {
                          ref
                              .read(posGlobalProvider.notifier)
                              .doKeyExchange(context: context);
                        },
                        label: 'Download',
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
                // onPressed: () => _navCheck(Routes.login),
                onPressed: () => context.push(Routes.login),
                buttonTitle: 'Login',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navCheck(String route) async {
    //context.push(route);
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
}
