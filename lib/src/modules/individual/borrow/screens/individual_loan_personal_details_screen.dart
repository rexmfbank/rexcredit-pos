import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_application_address_date.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_application_dropdown_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/fetch_loan_lookup_data_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualLoanPersonalDetailScreen extends ConsumerWidget {
  const IndividualLoanPersonalDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLoanApplication = ref.watch(selectedLoanApplicationProvider);
    if (selectedLoanApplication != null) {
      ref.watch(loanApplicationProvider).residentialAddressController.text =
          selectedLoanApplication.residentialAddress!;
      ref.watch(loanApplicationProvider).noOfDependantsController.text =
          selectedLoanApplication.noOfDependants!.toString();
    }
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.personalInfoTitle,
        subtitle: StringAssets.personalDetailsSubtitle,
      ),
      body: Stack(children: [
        Form(
          key: ref.watch(loanApplicationProvider).formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 12.0),
              LoanApplicationDropdownWidget(
                title: StringAssets.maritalStatus,
                selectedStatus: selectedLoanApplication?.maritalStatus ??
                    ref.watch(loanApplicationProvider).selectedMaritalStatus,
                dropdownDataList: ref.watch(fetchMaritalStatusList),
                onChanged: (item) {
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setSelectedMaritalStatus(item!.description);
                },
              ),
              const SizedBox(height: 6),
              RexTextField(
                outerTitle: StringAssets.residentAddressTitle,
                hintText: StringAssets.enterAddress,
                controller: ref
                    .watch(loanApplicationProvider)
                    .residentialAddressController,
                obscureText: false,
                showOuterTile: true,
                inputType: TextInputType.text,
                hasInputFormat: true,
                onChanged: (p0) => ref
                    .watch(loanApplicationProvider)
                    .residentialAddressController,
                validator: (value) => TextfieldValidator.input(value),
              ),
              const LoanApplicationAddressDate(),
              const SizedBox(height: 16),
              RexTextField(
                outerTitle: StringAssets.noOfDependants,
                showOuterTile: true,
                controller:
                    ref.watch(loanApplicationProvider).noOfDependantsController,
                hintText: StringAssets.enterNoOfDependants,
                inputType: TextInputType.number,
                obscureText: false,
                validator: (value) => TextfieldValidator.integer(value),
              ),
              const SizedBox(height: 16),
              LoanApplicationDropdownWidget(
                title: StringAssets.educationalStatus,
                selectedStatus: selectedLoanApplication?.educationalStatus ??
                    ref
                        .watch(loanApplicationProvider)
                        .selectedEducationalStatus,
                dropdownDataList: ref.watch(fetchEducationalStatusList),
                onChanged: (item) {
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setSelectedEducationalStatus(item!.description);
                },
              ),
              const SizedBox(height: 16),
              LoanApplicationDropdownWidget(
                title: StringAssets.employmentStatusTitle,
                selectedStatus:
                    ref.watch(loanApplicationProvider).selectedEmploymentStatus,
                dropdownDataList: ref.watch(fetchEmploymentStatusList),
                onChanged: (item) {
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setSelectedEmploymentStatus(item!.description);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                child: RexFlatButton(
                  onPressed: () {
                    ref.read(loanApplicationProvider.notifier).updateError();
                    ref
                        .read(loanApplicationProvider.notifier)
                        .onValidatePersonalDetails(context);
                  },
                  buttonTitle: StringAssets.nextTextOnButton,
                  backgroundColor: null,
                ),
              ),
            ],
          ),
        ),
        if (ref.watch(loanApplicationProvider).isLoading)
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ]),
    );
  }
}
