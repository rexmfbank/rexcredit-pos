import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class IndividualLoanConnectBankScreen extends StatefulHookConsumerWidget {
  const IndividualLoanConnectBankScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLoanConnectBankScreenState();
}

class _IndividualLoanConnectBankScreenState
    extends ConsumerState<IndividualLoanConnectBankScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final ippisNumberController = useTextEditingController();

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Connect your bank',
        subtitle: 'Add the code from your bank',
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            RexTextField(
              outerTitle: 'Enter your IPPIS number',
              hintText: 'Enter IPPIS number',
              controller: ippisNumberController,
              obscureText: false,
              inputType: TextInputType.number,
              hasInputFormat: true,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  // showModalAction(
                  //   context: context,
                  //   dialogTitle: 'IPPIS Number verified',
                  //   dialogSubtitle: 'We have succesfully verified your IPPIS',
                  //   onPressed: () {
                  //     context.pop();
                  //     context.push(
                  //         '${RouteName.dashboardBorrow}/${RouteName.pubConnectBankDetails}');
                  //   },
                  // );
                },
                buttonTitle: 'Verify',
                backgroundColor: null,
                // backgroundColor: _formKey.currentState?.validate() == true
                //     ? null
                //     : AppColors.cardGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
