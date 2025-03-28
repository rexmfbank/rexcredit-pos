import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/employer_status_dropdown.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class IndividualLoanEmploymentProfileScreen extends StatefulHookConsumerWidget {
  const IndividualLoanEmploymentProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PublicEmployeeEmploymentProfileScreenState();
}

class _PublicEmployeeEmploymentProfileScreenState
    extends ConsumerState<IndividualLoanEmploymentProfileScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(loanApplicationProvider.notifier).fetchStates();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: null,
        title: StringAssets.employmentProfileTitle,
        subtitle: StringAssets.employmentProfileSubtitle,
      ),
      body: Stack(children: [
        Form(
          key: ref.watch(loanApplicationProvider).formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const EmployerStatusDropdown(),
              const SizedBox(height: 8),
              RexTextField(
                outerTitle: StringAssets.monthlyIncomeTitle,
                hintText: StringAssets.monthlyIncomeHint,
                inputType: TextInputType.number,
                controller: ref.watch(loanApplicationProvider).incomeController,
                validator: (value) => TextfieldValidator.amount(value),
                obscureText: false,
              ),
              RexTextField(
                outerTitle: StringAssets.employerNameTitle,
                hintText: StringAssets.enterCompanyName,
                controller:
                    ref.watch(loanApplicationProvider).employerNameController,
                validator: (value) => TextfieldValidator.name(value),
                obscureText: false,
              ),
              RexTextField(
                outerTitle: StringAssets.employerAddress,
                hintText: StringAssets.employerAddressHint,
                controller: ref
                    .watch(loanApplicationProvider)
                    .employerAddressController,
                validator: (value) => TextfieldValidator.name(value),
                obscureText: false,
              ),
              const SizedBox(
                height: 4,
              ),
              RexCustomSpinner(
                title: StringAssets.employerState,
                options: ref
                    .watch(loanApplicationProvider)
                    .nigeriaStates
                    .map((e) => e.state.name)
                    .toList(),
                onOptionChanged: (p0) {
                  ref.read(loanApplicationProvider.notifier).setSelectedState =
                      p0!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              RexCustomSpinner(
                title: StringAssets.stateLGA,
                options: ref
                        .watch(loanApplicationProvider)
                        .selectedNigeriaState
                        .isBlank
                    ? []
                    : ref
                        .watch(loanApplicationProvider)
                        .nigeriaStates
                        .firstWhere((element) =>
                            element.state.name ==
                            ref
                                .watch(loanApplicationProvider)
                                .selectedNigeriaState)
                        .state
                        .locals,
                onOptionChanged: (p0) {
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setSelectedEmployerLga = p0!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              RexCustomSpinner(
                title: StringAssets.companyIndustryTitle,
                options: ref.watch(loanApplicationProvider).companyIndustries,
                onOptionChanged: (p0) {
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setSelectedIndustry = p0!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              RexCustomSpinner(
                title: StringAssets.companySector,
                options: ref
                    .watch(loanApplicationProvider)
                    .nigeriaStates
                    .map((e) => e.state.name)
                    .toList(),
                onOptionChanged: (p0) {
                  ref.read(loanApplicationProvider.notifier).setSelectedState =
                      p0!;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                child: Text(
                  StringAssets.dateOfResumptionTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1903),
                    lastDate: DateTime.now(),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        ref
                            .read(loanApplicationProvider.notifier)
                            .setSelectedDate(selectedDate);
                      });
                    }
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    ref.watch(loanApplicationProvider).selectedResumptionDate ??
                        StringAssets.selectDate,
                    style: const TextStyle(
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RexTextField(
                outerTitle: StringAssets.workEmailTitle,
                hintText: StringAssets.workEmailHint,
                controller:
                    ref.watch(loanApplicationProvider).employerNameController,
                validator: (value) => TextfieldValidator.name(value),
                obscureText: false,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                child: RexElevatedButton(
                  onPressed: () {
                    ref
                        .read(loanApplicationProvider.notifier)
                        .onValidateEmploymentDetails(context);
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
