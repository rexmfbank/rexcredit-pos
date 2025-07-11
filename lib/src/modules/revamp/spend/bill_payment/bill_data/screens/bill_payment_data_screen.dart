import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_data/widgets/data_new_payment_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/widgets/saved_payment_tab.dart';
import 'package:rex_app/src/modules/revamp/spend/widgets/account_balance_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import '../../../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../../../shared/widgets/page_widgets/custom_app_bar.dart';
import '../../shared/widgets/bill_payment_tab_bar.dart';
import '../../shared/providers/bill_payment_provider.dart';

class BillPaymentDataScreen extends ConsumerStatefulWidget {
  const BillPaymentDataScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillPaymentDataScreen();
}

class _BillPaymentDataScreen extends ConsumerState<BillPaymentDataScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(billPaymentProvider.notifier)
          .setUpDataTab(length: 2, vsync: this);
      ref
          .read(billPaymentProvider.notifier)
          .fetchAllBillers(context, BillerCategories.data);
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
        title: StringAssets.data,
        subtitle: StringAssets.buyDataFromAnyNetwork,
        showImage: false,
        showNotification: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AccountBalanceCard(),
            SizedBox(height: 16.h),
            BillPaymentTabBar(
                tabController:
                    ref.watch(billPaymentProvider).dataTabController!,
                length: 2),
            SizedBox(height: 16.h),
            Flexible(
              child: TabBarView(
                controller: ref.watch(billPaymentProvider).dataTabController!,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DataNewPaymentTab(),
                  SavedPaymentTab(
                    TransactionCodes.data,
                    beneficiaryName: StringAssets.dataBeneficiary,
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
