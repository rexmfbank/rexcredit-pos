import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_application_card.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/extensions/extension_on_double.dart';

class LoanApplicationListView extends ConsumerWidget {
  const LoanApplicationListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(loanProductsProvider);
    var loanApplications = state.loanApplications ?? [];

    return Stack(children: [
      SizedBox(
        height: 550,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: loanApplications.length,
            itemBuilder: (context, index) {
              return LoanApplicationCard(
                  iconPath: AssetPath.individualLoanProduct,
                  loanProductTitle: loanApplications[index].loanTitle,
                  loanProductSubTitle: addNairaCurrencySymbol(
                      loanApplications[index]
                          .amountApplied
                          .toNairaAmountFormat()),
                  status: loanApplications[index].status!,
                  onTap: () {
                    ref.read(selectedLoanRefCodeProvider.notifier).state =
                        loanApplications[index].refNo;
                    ref.read(selectedLoanApplicationProvider.notifier).state =
                        loanApplications[index];
                    if (loanApplications[index].status == 'APPLIED' ||
                        loanApplications[index].status == 'APPROVED' ||
                        loanApplications[index].status == 'ACCEPTED') {
                      context.push(
                          '${Routes.dashboardBorrow}/${Routes.individualLoanApplicationPending}');
                    } else if (loanApplications[index].status == 'ACTIVE') {
                      context.push(
                          '${Routes.dashboardBorrow}/${Routes.individualLoanActiveDashboard}');
                    } else {
                      context.push(
                          '${Routes.dashboardBorrow}/${Routes.individualLoanDocumentation}');
                    }
                  });
            }),
      ),
      if (state.isLoading)
        const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    ]);
  }
}
