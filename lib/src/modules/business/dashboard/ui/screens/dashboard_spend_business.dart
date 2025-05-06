import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/screens/bill_payments_screen.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../utils/constants/string_assets.dart';
import '../../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../../shared/widgets/page_widgets/custom_app_bar.dart';

class DashboardSpendBusiness extends StatefulHookConsumerWidget {
  const DashboardSpendBusiness({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardSpendBusinessState();
}

class _DashboardSpendBusinessState extends ConsumerState<DashboardSpendBusiness>
    with SingleTickerProviderStateMixin, AppActionsMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: CustomAppBar(
        shouldHaveBackButton: false,
        title: StringAssets.billPayments,
        subtitle: StringAssets.billPaymentsSubtitle,
      ),
      body: BillPaymentsScreen(),
    );
  }
}
