import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/borrow/components/business_bank_statement_header.dart';
import 'package:rex_app/src/modules/business/borrow/components/business_select_bank_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessBankStatementScreen extends StatefulHookConsumerWidget {
  const BusinessBankStatementScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessBankStatementScreenState();
}

class _BusinessBankStatementScreenState
    extends ConsumerState<BusinessBankStatementScreen> {
  @override
  Widget build(BuildContext context) {
    final accountController = useTextEditingController();
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Bank Statement',
        subtitle:
            'Enter your business bank details, we would use this to generate your bank statement',
      ),
      body: ListView(
        children: [
          const BusinessBankStatementHeader(
            text: 'Your business bank details have been validated.',
          ),
          const BusinessSelectBankDropdown(),
          RexTextField(
            outerTitle: 'Account Number',
            hintText: '',
            controller: accountController,
            obscureText: false,
            showOuterTile: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: RexElevatedButton(
              onPressed: () {
                context.push(
                  "${Routes.dashboardBorrowBusiness}/${Routes.businessBankStatementConfirm}",
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
