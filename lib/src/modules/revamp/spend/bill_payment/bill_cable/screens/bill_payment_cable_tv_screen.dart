import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_cable/widgets/cable_tv_new_payment_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_cable/provider/cable_tv_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/widgets/bill_payment_tab_bar.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/widgets/saved_payment_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/widgets/account_balance_card.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';

import '../../../../utils/config/theme/app_colors.dart';
import '../../../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../../../shared/widgets/page_widgets/custom_app_bar.dart';
import '../../shared/providers/bill_payment_provider.dart';

class BillPaymentCableTvScreen extends ConsumerStatefulWidget {
  const BillPaymentCableTvScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillPaymentCableTvScreenState();
}

class _BillPaymentCableTvScreenState
    extends ConsumerState<BillPaymentCableTvScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(billPaymentProvider.notifier).setUpCableTab(
            length: 2,
            vsync: this,
          );
      ref
          .read(billPaymentProvider.notifier)
          .fetchAllBillers(context, BillerCategories.cable);
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
        shouldHaveBackButton: true,
        title: StringAssets.cableTv,
        subtitle: StringAssets.rechargeCableTvFromAccount,
        showImage: false,
        showNotification: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const AccountBalanceCard(),
            SizedBox(height: 16.h),
            BillPaymentTabBar(
              tabController: ref.watch(billPaymentProvider).cableTabController!,
              length: 2,
            ),
            SizedBox(height: 16.h),
            Flexible(
              child: TabBarView(
                controller: ref.watch(billPaymentProvider).cableTabController!,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  CableTvNewPaymentTab(),
                  SavedPaymentTab(
                    TransactionCodes.cable,
                    beneficiaryName: StringAssets.cableBeneficiary,
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
