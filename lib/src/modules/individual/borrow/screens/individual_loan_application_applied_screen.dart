import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/approved_loan_cta_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/components/pending_loan_application_details.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/loan_offer_letter_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/navigation.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_double.dart';

class IndividualLoanApplicationAppliedScreen
    extends StatefulHookConsumerWidget {
  const IndividualLoanApplicationAppliedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLoanApplicationAppliedScreenState();
}

class _IndividualLoanApplicationAppliedScreenState
    extends ConsumerState<IndividualLoanApplicationAppliedScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String? loanRefCode = ref.watch(selectedLoanRefCodeProvider);
      if (loanRefCode != null) {
        ref
            .read(loanApplicationProvider.notifier)
            .fetchSingleLoanApplication(context, loanRefCode);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loanApplication = ref.watch(selectedLoanApplicationProvider);
    //
    return Scaffold(
      appBar: RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.loanApplicationTitle,
        subtitle: StringAssets.loanApplicationSubtitle(
            loanApplication!.amountApplied.toNairaAmountFormat(),
            loanApplication.status!),
      ),
      body: Stack(children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 12.0),
            const PendingLoanApplicationDetails(),
            loanApplication.status == "APPROVED"
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: RexFlatButton(
                      onPressed: () {
                        var refCode = ref.watch(selectedLoanRefCodeProvider);
                        ref
                            .read(loanApplicationProvider.notifier)
                            .setOfferPDFLink(loanApplication.offerPDFLink);
                        context.pushSuper(
                          LoanOfferPdfViewerScreen(
                              pdfUrl:
                                  ApiPath.getLoanOfferPDFLink(refCode) ?? ''),
                        );
                      },
                      buttonTitle: StringAssets.viewOfferLetterButtonText,
                      backgroundColor: AppColors.rexLightBlue2,
                      borderColor: AppColors.rexLightBlue2,
                    ),
                  )
                : Container(),
            loanApplication.status == "APPROVED"
                ? const ApprovedLoanCtaWidget()
                : Container(),
          ],
        ),
        if (ref.watch(loanApplicationProvider).isLoading)
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ]),
    );
  }
}
