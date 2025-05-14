import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_product_card.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';

class LoanProductsListView extends ConsumerWidget {
  const LoanProductsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(loanProductsProvider);
    var loanProducts = state.loanProducts ?? [];

    return Stack(
      children: [
        if (loanProducts.isNotEmpty)
          SizedBox(
            height: 550,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: loanProducts.length,
              itemBuilder: (context, index) {
                return LoanProductCard(
                  iconPath: getIconPath(loanProducts[index].title),
                  loanProductTitle: loanProducts[index].productName,
                  loanProductSubTitle: loanProducts[index].description ?? '',
                  onTap: () {
                    ref.read(selectedLoanProductProvider.notifier).state =
                        loanProducts[index];
                    ref
                        .read(loanProductsProvider.notifier)
                        .fetchSingleLoanProduct(
                            context, loanProducts[index].productCode);
                    ref
                        .read(loanProductsProvider.notifier)
                        .fetchLoanPurposeOptions(context);
                    context.push(getNavigationPath(loanProducts[index].title));
                  },
                );
              },
            ),
          )
        else
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child:
                      Lottie.asset('assets/lottiefiles/investment_icon.json'),
                ),
                const Text(
                  "You have no loan product at the moment!",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexPurpleDark2),
                )
              ],
            ),
          ),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ],
    );
  }

  String getIconPath(String title) {
    final iconPaths = {
      "INDIVIDUAL": "assets/png/individual_icon.png",
      "EMPLOYEE": "assets/png/employee_loan_icon.png",
      // Add more mappings as needed
    };

    // Return the corresponding icon path or a default string if not found
    return iconPaths[title] ?? "assets/png/individual_icon.png";
  }

  String getNavigationPath(String path) {
    final navPaths = {
      "INDIVIDUAL": '${Routes.dashboardBorrow}/${Routes.individualBorrow}',
      "EMPLOYEE": '${Routes.dashboardBorrow}/${Routes.employeeLoanType}',
      // Add more mappings as needed
    };
    // Return the corresponding icon path or a default string if not found
    return navPaths[path] ??
        '${Routes.dashboardBorrow}/${Routes.individualBorrow}';
  }
}
