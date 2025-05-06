import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/src/utils/enums/app_menu_type.dart';
import 'package:rex_app/src/modules/individual/borrow/components/dashboard_borrow_appbar.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_application_list_item_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_product_list_item_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/feature_disable_page.dart';
import 'package:rex_app/src/utils/enums/loan_status.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

class DashboardBorrow extends StatefulHookConsumerWidget {
  const DashboardBorrow({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardBorrowState();
}

class _DashboardBorrowState extends ConsumerState<DashboardBorrow>
    with AppActionsMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loanProductsProvider.notifier).fetchUserLoanApplication(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userLoanApplications =
        ref.watch(loanProductsProvider).loanApplications ?? [];
    userLoanApplications = userLoanApplications
        .where((element) => ![
              LoanStatus.completed.jsonString,
              LoanStatus.declined.jsonString,
              LoanStatus.rejected.jsonString,
              LoanStatus.terminated.jsonString,
              LoanStatus.closed.jsonString
            ].contains(element.status))
        .toList();

    return Scaffold(
      appBar: const DashboardBorrowAppBar(),
      body: !featureEnabledCheck(
        context: context,
        feature:
            (ref.watch(loginProvider).loginResponse.value?.data.appMenu ?? [])
                .firstWhere((element) =>
                    (element.menuCode?.jsonString ?? '') ==
                    AppMenuType.loan.jsonString),
      )
          ? const FeatureDisablePage()
          : userLoanApplications.isEmpty
              ? const LoanProductsListView()
              : const LoanApplicationListView(),
    );
  }
}
