import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_electricity/widgets/electricity_new_payment_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/widgets/bill_payment_tab_bar.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/widgets/saved_payment_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/widgets/account_balance_card.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/enums/enums.dart';

import '../../../../utils/config/theme/app_colors.dart';
import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../../../shared/widgets/page_widgets/custom_app_bar.dart';
import '../../shared/providers/bill_payment_provider.dart';

class BillPaymentElectricityScreen extends ConsumerStatefulWidget {
  const BillPaymentElectricityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillPaymentElectricityScreenState();
}

class _BillPaymentElectricityScreenState
    extends ConsumerState<BillPaymentElectricityScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(billPaymentProvider.notifier)
          .setUpElectricityTab(length: 2, vsync: this);
      ref
          .read(billPaymentProvider.notifier)
          .fetchAllBillers(context, BillerCategories.electricity);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(billPaymentProvider).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: StringAssets.powerUtility,
        subtitle: StringAssets.payPowerUtilityFromAccount,
        showImage: false,
        showNotification: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const AccountBalanceCard(),
            SizedBox(height: 16.ah),
            BillPaymentTabBar(
              tabController:
                  ref.watch(billPaymentProvider).electricityTabController!,
              length: 2,
            ),
            SizedBox(height: 16.ah),
            Flexible(
              child: TabBarView(
                controller:
                    ref.watch(billPaymentProvider).electricityTabController!,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ElectricityNewPaymentTab(),
                  SavedPaymentTab(
                    TransactionCodes.power,
                    beneficiaryName: StringAssets.electricityBeneficiary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
