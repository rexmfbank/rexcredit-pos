import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_amount_duration_card.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_repayment_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class BusinessLoanApplicationScreen extends StatelessWidget {
  const BusinessLoanApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Working Capital',
        subtitle: 'Apply for a business loan',
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8.0),
          const LoanRepaymentAmountCard(
            amount: "N56,040",
          ),
          const SizedBox(height: 16.0),
          const LoanAmountDurationCard(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: RexFlatButton(
              onPressed: () {
                context.push(
                  "${Routes.dashboardBorrowBusiness}/${Routes.businessLoanSubmit}",
                );
              },
              buttonTitle: 'Save & Continue',
              backgroundColor: AppColors.rexPurpleLight,
            ),
          ),
        ],
      ),
    );
  }
}
