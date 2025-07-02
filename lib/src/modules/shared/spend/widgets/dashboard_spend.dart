import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/screens/bill_payments_screen.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

import '../../../revamp/utils/config/theme/app_colors.dart';
import '../../../../utils/constants/string_assets.dart';
import '../../../shared/widgets/page_widgets/app_scaffold.dart';
import '../../../shared/widgets/page_widgets/custom_app_bar.dart';

class DashboardSpend extends ConsumerStatefulWidget {
  const DashboardSpend({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardSpendState();
}

class _DashboardSpendState extends ConsumerState<DashboardSpend>
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
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        shouldHaveBackButton: false,
        title: StringAssets.billPayments,
        subtitle: StringAssets.billPaymentsSubtitle,
      ),
      body: BillPaymentsScreen(),
    );
  }
}
