import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/borrow/components/active_loan_outstanding_card.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_percentage_paid_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/components/next_loan_repayment_date_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/components/repayment_date_list_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_management_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualLoanActiveLoanScreen extends StatefulHookConsumerWidget {
  const IndividualLoanActiveLoanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLoanActiveLoanScreenState();
}

class _IndividualLoanActiveLoanScreenState
    extends ConsumerState<IndividualLoanActiveLoanScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loanManagementProvider.notifier).fetchLoanDetail(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.loanActiveTitle,
        subtitle: StringAssets.loanActiveSubtitle,
      ),
      body: Stack(children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            SizedBox(height: 12.0),
            ActiveLoanOutstandingCard(),
            SizedBox(height: 16.0),
            LoanPercentagePaidWidget(),
            NextLoanRepaymentDateWidget(),
            RepaymentDateListWidget(),
          ],
        ),
        if (ref.watch(loanApplicationProvider).isLoading)
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ]),
    );
  }
}
