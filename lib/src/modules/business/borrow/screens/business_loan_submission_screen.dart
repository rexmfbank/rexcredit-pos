import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_option_with_icon_item_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessLoanSubmissionScreen extends StatelessWidget {
  const BusinessLoanSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Apply for a loan',
        subtitle: 'We need more information to complete your application.',
      ),
      body: ListView(
        children: [
          InvestmentTypeCard(
            iconPath: 'assets/png/briefcase_icon.png',
            investmentTitle: 'Business documents',
            investmentSubTitle: 'Share details about your employment',
            onTap: () {
              context.push(
                  '${Routes.dashboardBorrowBusiness}/${Routes.businessDocuments}');
            },
          ),
          const SizedBox(height: 6.0),
          InvestmentTypeCard(
            iconPath: 'assets/png/person_icon.png',
            investmentTitle: 'ID Verification',
            investmentSubTitle: 'Some additional info are required',
            onTap: () {
              context.push(
                '${Routes.dashboardBorrowBusiness}/${Routes.businessIdVerify}',
              );
            },
          ),
          const SizedBox(height: 6.0),
          InvestmentTypeCard(
            iconPath: 'assets/png/document_icon.png',
            investmentTitle: 'Bank statement',
            investmentSubTitle: 'Add business account bank statement',
            onTap: () {
              context.push(
                  '${Routes.dashboardBorrowBusiness}/${Routes.businessBankStatement}');
            },
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: RexElevatedButton(
              onPressed: () {
                showModalAction(
                  context: context,
                  buttonTitle: 'Yes, Submit',
                  dialogTitle: 'Submit Application?',
                  dialogSubtitle:
                      'Your loan application will be submitted now. Please Confirm the details submitted.',
                  onPressed: () {
                    context.pop();
                    showModalAction(
                      context: context,
                      dialogTitle: 'Application Submitted!',
                      dialogSubtitle:
                          'Your loan application is pending review, should you be granted this loan, you will receive a loan offer from us.',
                      onPressed: () {
                        context.go(Routes.dashboardBusiness);
                      },
                    );
                  },
                );
              },
              buttonTitle: StringAssets.submitTextOnButton,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
