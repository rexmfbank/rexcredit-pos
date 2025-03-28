import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoanApplicationAddressDate extends ConsumerWidget {
  const LoanApplicationAddressDate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(loanApplicationProvider);
    final selectedLoanApplication = ref.watch(selectedLoanApplicationProvider);
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1920),
            lastDate: DateTime.now(),
          ).then((value) {
            ref.read(loanApplicationProvider.notifier).setSelectedDate(value);
          });
        },
        child: RexTextField(
          outerTitle: StringAssets.timeLivedInAddress,
          obscureText: false,
          hintText: selectedLoanApplication != null
              ? selectedLoanApplication.inResidenceSince!
              : provider.selectedDateInAddress ?? StringAssets.selectDate,
          controller: provider.addressDateController,
          showOuterTile: true,
          enabled: false,
        ),
      ),
    );
  }
}
