import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/provider/reset_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class NewTransactionPinScreen extends ConsumerWidget {
  const NewTransactionPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(resetTransactionPinProvider);

    return AppScaffold(
      isLoading: provider.isLoading,
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.all(0),
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: null,
        title: StringAssets.enterTransactionPinTitle,
        subtitle: 'Create a new transaction PIN',
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 8),
          RexTextFieldPassword(
            controller: provider.newController,
            outerTitle: 'Enter New PIN',
            hintText: '',
            textFieldIsRequired: true,
            inputType: TextInputType.number,
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RexElevatedButton(
              onPressed:
                  () => ref
                      .read(resetTransactionPinProvider.notifier)
                      .resetTransactionPin(context),
              buttonTitle: 'Submit',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
