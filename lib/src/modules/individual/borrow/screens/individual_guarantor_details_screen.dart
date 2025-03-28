import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/borrow/components/loan_application_dropdown_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/fetch_loan_lookup_data_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualGuarantorDetailScreen extends StatefulHookConsumerWidget {
  const IndividualGuarantorDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualGuarantorDetailScreenState();
}

class _IndividualGuarantorDetailScreenState
    extends ConsumerState<IndividualGuarantorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final loanApplication = ref.watch(selectedLoanApplicationProvider);
    if (loanApplication != null && loanApplication.guarantorDetails != null) {
      ref.watch(loanApplicationProvider).guarantorFirstnameController.text =
          loanApplication.guarantorDetails!.firstName;
      ref.watch(loanApplicationProvider).guarantorLastnameController.text =
          loanApplication.guarantorDetails!.lastName;
      ref.watch(loanApplicationProvider).guarantorEmailController.text =
          loanApplication.guarantorDetails!.email!;
      ref.watch(loanApplicationProvider).guarantorPhoneNoController.text =
          loanApplication.guarantorDetails!.phoneNumber!;
    }
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.guarantorDetailsTitle,
        subtitle: StringAssets.guarantorDetailsSubtitle,
      ),
      body: Stack(children: [
        Form(
          key: ref.watch(loanApplicationProvider).formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              RexTextField(
                outerTitle: StringAssets.firstNameTitle,
                hintText: StringAssets.firstNameHint,
                controller: ref
                    .watch(loanApplicationProvider)
                    .guarantorFirstnameController,
                obscureText: false,
                showOuterTile: true,
                inputType: TextInputType.text,
                validator: (value) => TextfieldValidator.name(value),
              ),
              RexTextField(
                outerTitle: StringAssets.surnameTitle,
                showOuterTile: true,
                hintText: StringAssets.surnameHint,
                controller: ref
                    .watch(loanApplicationProvider)
                    .guarantorLastnameController,
                obscureText: false,
                inputType: TextInputType.text,
                validator: (value) => TextfieldValidator.name(value),
              ),
              LoanApplicationDropdownWidget(
                title: StringAssets.relationshipTitle,
                selectedStatus:
                    loanApplication?.guarantorDetails?.relationship ??
                        ref
                            .watch(loanApplicationProvider)
                            .selectedGuarantorRelationship,
                dropdownDataList: ref.watch(fetchGuarantorRelationshipList),
                onChanged: (value) {
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setSelectedGuarantorRelationshipStatus(
                          value!.description);
                },
              ),
              RexTextField(
                outerTitle: StringAssets.emailAddressTitle,
                showOuterTile: true,
                hintText: StringAssets.emailAddressHint2,
                controller:
                    ref.watch(loanApplicationProvider).guarantorEmailController,
                obscureText: false,
                inputType: TextInputType.emailAddress,
                validator: (value) => TextfieldValidator.email(value),
              ),
              RexTextField(
                outerTitle: StringAssets.phoneNumberTitle,
                showOuterTile: true,
                hintText: StringAssets.phoneNumberHint2,
                controller: ref
                    .watch(loanApplicationProvider)
                    .guarantorPhoneNoController,
                obscureText: false,
                inputType: TextInputType.phone,
                validator: (value) => TextfieldValidator.phoneNumber(value),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: RexFlatButton(
                  onPressed: () {
                    ref.read(loanApplicationProvider.notifier).updateError();
                    ref
                        .read(loanApplicationProvider.notifier)
                        .onValidateGuarantorDetails(context);
                  },
                  buttonTitle: StringAssets.saveAndContinueText,
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
