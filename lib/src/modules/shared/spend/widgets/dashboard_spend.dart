import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/src/utils/enums/app_menu_type.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/screens/bill_payments_screen.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/screens/transfer_screen.dart';
import 'package:rex_app/src/modules/shared/spend/widgets/account_balance_card.dart';
import 'package:rex_app/src/modules/shared/spend/widgets/spend_tab_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/feature_disable_page.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

import '../../../../config/theme/app_colors.dart';
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
