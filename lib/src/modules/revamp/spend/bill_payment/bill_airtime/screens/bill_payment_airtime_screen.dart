import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_airtime/widgets/airtime_buy_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/widgets/saved_payment_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/widgets/account_balance_card.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/utils/enums/enums.dart';

import '../../../../utils/config/theme/app_colors.dart';
import '../../../../../shared/widgets/page_widgets/custom_app_bar.dart';
import '../../shared/widgets/bill_payment_tab_bar.dart';

class BillPaymentAirtimeScreen extends ConsumerStatefulWidget {
  const BillPaymentAirtimeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillPaymentAirtimeScreenState();
}

class _BillPaymentAirtimeScreenState
    extends ConsumerState<BillPaymentAirtimeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref
      //     .read(billPaymentProvider.notifier)
      //     .setUpAirTimeTab(length: 2, vsync: this);
      ref
          .read(billPaymentProvider.notifier)
          .fetchAllBillers(context, BillerCategories.airtime);
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
        title: StringAssets.airtimeTitle,
        subtitle: StringAssets.airtimeSubtitle,
        showImage: false,
        showNotification: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const AccountBalanceCard(),
            SizedBox(height: 16.h),
            BillPaymentTabBar(
              tabController:
                  ref.watch(billPaymentProvider).airtimeTabController!,
              length: 2,
              firstTabText: StringAssets.buyAirtime,
            ),
            SizedBox(height: 16.h),
            Flexible(
              child: TabBarView(
                controller:
                    ref.watch(billPaymentProvider).airtimeTabController!,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  AirtimeBuyTab(),
                  SavedPaymentTab(
                    TransactionCodes.topUp,
                    beneficiaryName: StringAssets.airtimeBeneficiary,
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
