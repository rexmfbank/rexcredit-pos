import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_int_provider.dart';
import 'package:rex_app/src/modules/transfer/transfer_external_screen.dart';
import 'package:rex_app/src/modules/transfer/widgets/transaction_pin_sheet.dart';
import 'package:rex_app/src/modules/utils/general/app_text_validator.dart';

import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_bottom_sheet.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class InternalTransferScreen extends StatefulHookConsumerWidget {
  const InternalTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InternalTransferScreenState();
}

class _InternalTransferScreenState
    extends ConsumerState<InternalTransferScreen> {
  final Debouncer debouncer = Debouncer(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transferIntProvider);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        RexTextField(
          showOuterTile: true,
          textFieldIsRequired: true,
          maxLength: 10,
          outerTitle: Strings.accountNumber,
          hintText: Strings.accountNumberHint,
          controller: state.accountNumberController,
          obscureText: false,
          inputType: TextInputType.number,
          hasInputFormat: false,
          validator: (value) => AppTextValidator.walletNumber(value),
          onChanged: (value) {
            if (value.isNotEmpty && value.length == 10) {
              FocusScope.of(context).unfocus();
              debouncer.run(() async {
                ref
                    .read(transferIntProvider.notifier)
                    .validateAcct(context, value);
              });
            } else {
              debouncer.cancel();
            }
          },
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppColors.rexWhite,
          ),
          child: Text(state.recipientAcctName),
        ),
        SizedBox(height: 4.ah),
        RexTextField(
          prefixIcon: const RexTextFieldCurrencyIcon(),
          outerTitle: 'Transfer amount',
          textFieldIsRequired: true,
          showOuterTile: true,
          hintText: 'Enter amount',
          controller: state.amountController,
          obscureText: false,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          hasInputFormat: true,
          validator:
              (value) =>
                  AppTextValidator.minAmount(minAmount: 50, value: value),
          inputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'\d')),
            AmountTextInputFormatter(),
          ],
        ),
        SizedBox(height: 4.ah),
        RexTextField(
          showOuterTile: true,
          textFieldIsRequired: true,
          outerTitle: Strings.narration,
          hintText: 'Add a narration',
          controller: state.narrationController,
          obscureText: false,
          inputType: TextInputType.text,
          hasInputFormat: false,
          maxLength: 160,
        ),
        SizedBox(height: 15.ah),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw),
          child: RexFlatButton(
            onPressed: () {
              AppBottomSheet.showBottomsheet(
                context,
                useRootNavigator: false,
                widget: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TransactionPinSheet(
                    title: "Confirm pin",
                    onPinComplete: (v) {
                      context.pop();
                      ref
                          .read(transferIntProvider.notifier)
                          .internalTransfer(v, context);
                    },
                  ),
                ),
              );
            },
            buttonTitle: Strings.confirmTextOnButton,
            backgroundColor: null,
          ),
        ),
        SizedBox(height: 10.ah),
      ],
    );
  }
}
