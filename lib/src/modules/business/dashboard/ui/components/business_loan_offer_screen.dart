import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/business_loan_offer_card.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_accept_loan.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_decline_loan.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class BusinessLoanOfferScreen extends HookConsumerWidget {
  const BusinessLoanOfferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Loan Application',
        subtitle: 'Your requested loan amount of ₦50,000 has been approved',
      ),
      body: Column(
        children: [
          const BusinessLoanOfferCard(),
          RexElevatedButton(
            onPressed: () {
              showModalLoanOffer(
                context: context,
                onPressed: () {
                  context.pop();
                },
              );
            },
            buttonTitle: 'View offer letter',
            backgroundColor: AppColors.rexLightBlue3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Row(
              children: [
                Expanded(
                  child: RexElevatedButton(
                    onPressed: () {
                      showModalDeclineLoan(
                        context: context,
                        textController: textController,
                        onPressed: () {
                          context.pop();
                          showModalAction(
                            context: context,
                            dialogTitle: 'Loan offer declined',
                            dialogSubtitle:
                                "You have declined the proposed loan offer at this time. To get a new offer, please reapply.",
                            onPressed: () {
                              context.pop();
                            },
                          );
                        },
                      );
                    },
                    buttonTitle: 'Decline Offer',
                    backgroundColor: null,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: RexElevatedButton(
                    onPressed: () {
                      showModalAction(
                        context: context,
                        dialogTitle: 'Loan Offer Accepted',
                        dialogSubtitle:
                            "You have succesfullly accepted our loan offer, please proceed to set up a repayment method to disurbed your loan.",
                        onPressed: () {
                          context.pop();
                          context.push(
                              "${RouteName.dashboardBusiness}/${RouteName.businessLoanRepayment}");
                        },
                      );
                    },
                    buttonTitle: 'Accept Offer',
                    backgroundColor: null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
