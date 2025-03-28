import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_amount_and_tenor_card.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_amount_duration_card.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_application_dropdown_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/fetch_loan_lookup_data_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_calculation_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualLoanCalculationScreen extends ConsumerWidget {
  const IndividualLoanCalculationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(loanCalculationProvider);
    final loanProduct = ref.watch(selectedLoanProductProvider) ??
        const LoanProductModel.empty();
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.borrowTitle,
        subtitle: StringAssets.borrowSubtitle,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: 8.ah),
              const LoanAmountAndTenorCard(),
              SizedBox(height: 16.ah),
              const LoanAmountDurationCard(),
              SizedBox(height: 16.ah),
              LoanApplicationDropdownWidget(
                title: StringAssets.loanPurposeTitle,
                selectedStatus: ref
                    .watch(loanApplicationProvider)
                    .selectedEducationalStatus,
                dropdownDataList: ref.watch(fetchLoanPurposeList),
                onChanged: (item) {
                  ref
                      .read(loanCalculationProvider.notifier)
                      .setLoanPurpose(item!.description);
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setLoanPurpose(item.description);
                },
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.aw, vertical: 8.ah),
                child: RexFlatButton(
                  onPressed: () {
                    ref.read(loanCalculationProvider.notifier).onNavigate(
                          context,
                          loanProduct.minPrincipalAmount ?? 0,
                          loanProduct.maxPrincipalAmount ?? 0,
                        );
                  },
                  buttonTitle: StringAssets.saveAndContinueText,
                  backgroundColor: AppColors.rexPurpleLight,
                ),
              )
            ],
          ),
          if (state.isLoading)
            const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        ],
      ),
    );
  }
}
