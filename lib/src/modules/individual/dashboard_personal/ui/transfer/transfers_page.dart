import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transfer/external_transfer2_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transfer/widgets/transfer_tab_bar.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/screens/transfer_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TransfersPage extends ConsumerStatefulWidget {
  const TransfersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransfersPageState();
}

class _TransfersPageState extends ConsumerState<TransfersPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(homeTransferNotifier).isLoading,
      appBar: const CustomAppBar(
        shouldHaveBackButton: true,
        showImage: false,
        showAccountBalance: true,
        title: StringAssets.transferMoney,
        subtitle: StringAssets.toRexAccountOrOthers,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TransferTabBar(),
            SizedBox(height: 8.ah),
            Flexible(
              flex: 1,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller:
                    ref.watch(homeTransferNotifier).transferTabController,
                children: [
                  ExternalTransfer2Screen(),
                  const RexTransferScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class TransfersPage extends ConsumerStatefulWidget {
  const TransfersPage({super.key});

  @override
  ConsumerState<TransfersPage> createState() => _TransfersPageState();
}

class _TransfersPageState extends ConsumerState<TransfersPage>
    with SingleTickerProviderStateMixin, AppActionsMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeTransferNotifier.notifier).setUpTransferTabController(
            length: 2,
            vsync: this,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const CustomAppBar(
        shouldHaveBackButton: true,
        showImage: false,
        showAccountBalance: true,
        title: StringAssets.transferMoney,
        subtitle: StringAssets.toRexAccountOrOthers,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TransferTabBar(),
            SizedBox(height: 16.ah),
            Flexible(
              flex: 1,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller:
                    ref.watch(homeTransferNotifier).transferTabController,
                children: [
                  !featureEnabledCheck(
                    context: context,
                    feature: (ref
                                .watch(loginProvider)
                                .loginResponse
                                .value
                                ?.data
                                .appMenu ??
                            [])
                        .firstWhere((element) =>
                            (element.menuCode?.jsonString ?? '') ==
                            AppMenuType.interbank.jsonString),
                  )
                      ? const FeatureDisablePage()
                      : const ExternalTransferScreen(),
                  !featureEnabledCheck(
                    context: context,
                    feature: (ref
                                .watch(loginProvider)
                                .loginResponse
                                .value
                                ?.data
                                .appMenu ??
                            [])
                        .firstWhere((element) =>
                            (element.menuCode?.jsonString ?? '') ==
                            AppMenuType.internalTransfer.jsonString),
                  )
                      ? const FeatureDisablePage()
                      : const RexTransferScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
