import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/business/borrow/components/agent_loan_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AgentLoanRecommendedScreen extends StatelessWidget {
  const AgentLoanRecommendedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.recommendedLoan,
        subtitle: StringAssets.recommendedLoansSubtitle,
        hasActionButton: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: LoanProductsBuilder(),
      ),
    );
  }
}
