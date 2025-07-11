import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/transfer/external_transfer2_screen.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/transfer/widgets/transfer_tab_bar.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/screens/rex_transfer_screen.dart';
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
        showNotification: false,
        showImage: false,
        showAccountBalance: true,
        title: StringAssets.transferMoney,
        subtitle: StringAssets.toRexAccountOrOthers,
        height: 160,
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
