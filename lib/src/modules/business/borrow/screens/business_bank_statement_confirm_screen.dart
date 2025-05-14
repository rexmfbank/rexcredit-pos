import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/borrow/components/business_bank_statement_header.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessBankStatementConfirmScreen extends StatefulHookConsumerWidget {
  const BusinessBankStatementConfirmScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessBankStatementConfirmScreenState();
}

class _BusinessBankStatementConfirmScreenState
    extends ConsumerState<BusinessBankStatementConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    final tokenController = useTextEditingController();
    final pinController = useTextEditingController();
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Bank statement',
        subtitle:
            'Enter your business bank details, we would use this to generate your bank statement',
      ),
      body: ListView(
        children: [
          const BusinessBankStatementHeader(
            text:
                'We have successfully retrieved your bank statement from your account details.',
          ),
          RexTextField(
            outerTitle: 'MBS Token',
            hintText: '',
            controller: tokenController,
            obscureText: false,
            showOuterTile: true,
          ),
          RexTextField(
            outerTitle: 'MBS Pin',
            hintText: '',
            controller: pinController,
            obscureText: false,
            showOuterTile: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: RexElevatedButton(
              onPressed: () {
                context.go(
                  "${Routes.dashboardBorrowBusiness}/${Routes.businessLoanSubmit}",
                );
              },
              buttonTitle: 'Save & Continue',
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
