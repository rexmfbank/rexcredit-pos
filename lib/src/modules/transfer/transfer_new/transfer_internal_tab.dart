import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_provider.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_int_provider.dart';
import 'package:rex_app/src/modules/transfer/widgets/currency_icon.dart';
import 'package:rex_app/src/modules/transfer/widgets/name_inquiry_text.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/general/app_text_validator.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';

class TransferInternalTab extends ConsumerStatefulWidget {
  const TransferInternalTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransferInternalTabState();
}

class _TransferInternalTabState extends ConsumerState<TransferInternalTab> {
  @override
  Widget build(BuildContext context) {
    //
    ref.listen(transferIntProvider, (prev, next) {
      if (!context.mounted) return;
      if (next.msgError.isNotEmpty) {
        showAppDialog(
          context: context,
          title: 'Transaction Error',
          body: next.msgError,
          icon: Icons.error,
          onPressed: () {
            context.pop();
            ref.read(transferIntProvider.notifier).resetMessage();
          },
        );
      } else if (next.msgSuccess.isNotEmpty) {
        showAppDialogTransSuccess(
          context: context,
          onPressed: () {
            context.pop();
            ref.read(transferIntProvider.notifier).resetMessage();
            context.go(Routes.loginHome);
          },
        );
      }
    });
    //
    return TransferInternalTabBody();
  }
}

class TransferInternalTabBody extends ConsumerWidget {
  TransferInternalTabBody({super.key});

  final Debouncer debouncer = Debouncer(milliseconds: 800);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferIntProvider);
    return Column(
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
          suffixOuterTitle: state.recipientAcctName,
          validator: (value) => AppTextValidator.walletNumber(value),
          onChanged: (value) {
            if (value.isNotEmpty && value.length == 10) {
              FocusScope.of(context).unfocus();
              debouncer.run(() async {
                ref.read(transferIntProvider.notifier).validateAcct(value);
              });
            } else {
              debouncer.cancel();
            }
          },
        ),
        SizedBox(height: 2.ah),
        state.recipientAcctName.isEmpty
            ? SizedBox.shrink()
            : NameInquiryText(text: state.recipientAcctName),
        SizedBox(height: 4.ah),
        RexTextField(
          prefixIcon: const RexTextFieldCurrencyIcon(),
          outerTitle: 'Transfer Amount',
          textFieldIsRequired: true,
          showOuterTile: true,
          hintText: 'Enter amount',
          controller: state.amountController,
          obscureText: false,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          hasInputFormat: true,
          onChanged: (_) {
            ref.read(transferIntProvider.notifier).notifyFormChanged();
          },
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
          textFieldIsRequired: false,
          outerTitle: Strings.narration,
          hintText: 'Add a narration',
          controller: state.narrationController,
          obscureText: false,
          inputType: TextInputType.text,
          hasInputFormat: false,
          maxLength: 160,
        ),
        SizedBox(height: 10.ah),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw),
          child: RexElevatedButton(
            onPressed:
                state.isFormValid
                    ? () async {
                      final pin = await showPinDialog(context: context);
                      if (pin != null) {
                        ref
                            .read(transferIntProvider.notifier)
                            .internalTransfer(pin);
                      }
                    }
                    : null,
            buttonTitle: 'Confirm',
          ),
        ),
        SizedBox(height: 14),
      ],
    );
  }
}
