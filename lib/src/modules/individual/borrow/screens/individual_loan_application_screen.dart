import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/fetch_single_loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/dashboard_savings_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_option_with_icon_item_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class IndividualLoanDocScreen extends ConsumerWidget {
  const IndividualLoanDocScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singleLoanApply = ref.watch(fetchSingleLoanApplicationProvider);
    final loanProduct = ref.watch(selectedLoanProductProvider) ??
        const LoanProductModel.empty();
    //
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.borrowTitle,
        subtitle: StringAssets.borrowSubtitle,
      ),
      body: singleLoanApply.when(
        data: (loanApplication) {
          final isBankStatementRequired =
              loanProduct.maxPrincipalAmount! >= 500000 ||
                  loanApplication.bankStatementStatus != null;

          final isEmploymentDetailsRequired = loanProduct.title == "EMPLOYEE" ||
              loanProduct.productName == "EMPLOYEE" ||
              loanApplication.loanTitle == "EMPLOYEE";

          final isEmploymentSectionCompleted =
              loanApplication.status == "EMPLOYER" ||
                  loanApplication.status == "APPLIED";

          final isGuarantorSectionCompleted =
              loanApplication.status == "GUARANTOR" ||
                  isEmploymentSectionCompleted;

          final isPersonalSectionCompleted =
              loanApplication.status == "INITIATED" ||
                  isGuarantorSectionCompleted;

          final isLoanApplicationCompleted = isPersonalSectionCompleted &&
              isGuarantorSectionCompleted &&
              (isEmploymentSectionCompleted || !isEmploymentDetailsRequired) &&
              (!isBankStatementRequired || loanApplication.status == "APPLIED");
          return ListView(
            children: [
              InvestmentTypeCard(
                iconPath: isPersonalSectionCompleted
                    ? AssetPath.loanPersonalApplicationCompleted
                    : 'assets/png/person_icon.png',
                investmentTitle: StringAssets.personalDetailsTitle,
                investmentSubTitle: StringAssets.personalDetailsSubtitle2,
                isCompleted: isPersonalSectionCompleted,
                onTap: () {
                  context.push(
                      '${Routes.dashboardBorrow}/${Routes.individualPersonalDetail}');
                },
              ),
              const SizedBox(height: 6.0),
              InvestmentTypeCard(
                iconPath: isGuarantorSectionCompleted
                    ? AssetPath.loanPersonalApplicationCompleted
                    : 'assets/png/person_icon.png',
                investmentTitle: 'Guarantor Details',
                investmentSubTitle: 'Share details of your guarantor',
                isCompleted: isGuarantorSectionCompleted,
                onTap: () {
                  if (isPersonalSectionCompleted) {
                    context.push(
                        '${Routes.dashboardBorrow}/${Routes.individualGuarantorDetail}');
                  } else {
                    showModalActionError(
                        context: context,
                        errorText: 'Please complete personal details section!');
                  }
                },
              ),
              const SizedBox(height: 6.0),
              isEmploymentDetailsRequired
                  ? SizedBox(
                      child: InvestmentTypeCard(
                        iconPath: isEmploymentSectionCompleted
                            ? 'assets/png/briefcase.png'
                            : 'assets/png/briefcase_icon.png',
                        investmentTitle: 'Employment Details',
                        investmentSubTitle:
                            'Share details about your employment',
                        isCompleted: isEmploymentSectionCompleted,
                        onTap: () {
                          if (isGuarantorSectionCompleted) {
                            ref
                                .read(loanApplicationProvider.notifier)
                                .setSelectedEmploymentStatus("");
                            context.push(
                                '${Routes.dashboardBorrow}/${Routes.individualEmploymentDetails}');
                          } else {
                            showModalActionError(
                                context: context,
                                errorText:
                                    'Please complete guarantor details section!');
                          }
                        },
                      ),
                    )
                  : Container(),
              const SizedBox(height: 6.0),
              ref.watch(loanApplicationProvider).selectedAgency.isNotBlank
                  ? InvestmentTypeCard(
                      iconPath: 'assets/png/document_icon.png',
                      investmentTitle: 'Connect your bank',
                      investmentSubTitle: 'Some additional info are required',
                      onTap: () {
                        context.push(
                            '${Routes.dashboardBorrow}/${Routes.pubConnectBank}');
                      },
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RexFlatButton(
                  onPressed: () {
                    if (isLoanApplicationCompleted) {
                      ref
                          .read(loanApplicationProvider.notifier)
                          .onSubmitApplication(context);
                    } else if (isBankStatementRequired) {
                    } else {
                      showModalActionError(
                          context: context,
                          errorText:
                              'Please complete all information sections!');
                    }
                  },
                  buttonTitle: StringAssets.submitTextOnButton,
                  backgroundColor: AppColors.rexLightBlue2,
                  borderColor: AppColors.rexLightBlue2,
                ),
              )
            ],
          );
        },
        error: (error, stackTrace) => const Center(child: Text('Error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
