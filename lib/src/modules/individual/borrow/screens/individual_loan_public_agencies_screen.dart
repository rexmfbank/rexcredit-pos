import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualLoanPublicSectorAgenciesScreen extends ConsumerStatefulWidget {
  const IndividualLoanPublicSectorAgenciesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLoanPublicSectorAgenciesScreenState();
}

class _IndividualLoanPublicSectorAgenciesScreenState
    extends ConsumerState<IndividualLoanPublicSectorAgenciesScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(loanApplicationProvider.notifier).fetchStates();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.listOfAgenciesTitle,
        subtitle: StringAssets.listOfAgenciesSubtitle,
      ),
      body: ListView(
        children: [
          RexCustomSpinner(
            title: StringAssets.state,
            options: ref
                .watch(loanApplicationProvider)
                .nigeriaStates
                .map((e) => e.state.name)
                .toList(),
            onOptionChanged: (p0) {
              ref.read(loanApplicationProvider.notifier).setSelectedState = p0!;
            },
          ),
          const SizedBox(height: 16.0),
          RexCustomSpinner(
            title: StringAssets.selectAgency,
            options: ref.watch(loanApplicationProvider).publicAgencyOptions,
            onOptionChanged: (p0) {
              ref.read(loanApplicationProvider.notifier).setSelectedAgency = p0;
            },
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RexFlatButton(
              onPressed: () {
                ref.read(loanApplicationProvider.notifier).onValidateGovtAgency(context);
              },
              buttonTitle: StringAssets.saveAndContinueText,
              backgroundColor: AppColors.rexBlue,
            ),
          )
        ],
      ),
    );
  }
}
