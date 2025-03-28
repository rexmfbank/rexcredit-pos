import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/connect_bank_validation_text.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_confirm_salary_bank.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PublicEmployeeConnectBankDetailsScreen
    extends StatefulHookConsumerWidget {
  const PublicEmployeeConnectBankDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PublicEmployeeConnectBankDetailsScreenState();
}

class _PublicEmployeeConnectBankDetailsScreenState
    extends ConsumerState<PublicEmployeeConnectBankDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Connect your bank',
        subtitle: 'Add the code from your bank',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16.0),
              color: AppColors.rexWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ListTile(
                    title: Text('Account name'),
                    subtitle: Text('Adenike Ogunye'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Account Number'),
                    subtitle: Text('2001130011'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Bank name'),
                    subtitle: Text('First City Monument Bank'),
                  ),
                ],
              ),
            ),
            const ConnectBankValidationText(),
            Align(
              alignment: Alignment.center,
              child: RexElevatedButton(
                onPressed: () {
                  showModalConfirmSalaryBank(
                    context: context,
                    textController: textController,
                    onPressed: () {
                      context.pop();
                      showModalAction(
                        context: context,
                        dialogTitle: 'OTP Validated',
                        dialogSubtitle:
                            'We have successfully verified your IPPIS',
                        onPressed: () {
                          context.pop();
                          context.go(
                            "${RouteName.dashboardBorrow}/${RouteName.pubLoanDocScreen}",
                          );
                        },
                      );
                    },
                  );
                },
                backgroundColor: null,
                buttonTitle: StringAssets.nextTextOnButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
