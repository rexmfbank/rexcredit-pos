import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_provider.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_provider.dart';
import 'package:rex_app/src/modules/transfer/widgets/currency_icon.dart';
import 'package:rex_app/src/modules/transfer/widgets/name_inquiry_text.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/general/app_text_validator.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';

class TransferExternalTab extends ConsumerWidget {
  const TransferExternalTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    ref.listen(transferExtProvider, (previous, next) {
      if (!context.mounted) return;
      if (next.msgError.isNotEmpty) {
        showAppDialog(
          context: context,
          title: 'Transaction Error',
          body: next.msgError,
          icon: Icons.error,
          onPressed: () {
            context.pop();
            ref.read(transferExtProvider.notifier).resetMessage();
          },
        );
      } else if (next.msgSuccess.isNotEmpty) {
        showAppDialogTransSuccess(
          context: context,
          onPressed: () {
            context.pop();
            ref.read(transferExtProvider.notifier).resetMessage();
            ref.invalidate(dashboardProvider);
            context.go(Routes.loginHome);
          },
        );
      }
    });
    //
    return TransferExternalTabBody();
  }
}

class TransferExternalTabBody extends ConsumerWidget {
  TransferExternalTabBody({super.key});

  final debouncer = Debouncer(milliseconds: 800);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferExtProvider);
    return Column(
      children: [
        RexTextField(
          readOnly: true,
          textFieldIsRequired: true,
          outerTitle: 'Select a bank',
          showOuterTile: true,
          hintText: Strings.selectBank,
          controller: state.bankNameController,
          obscureText: false,
          validator: (value) => AppTextValidator.input(value),
          onTap:
              () =>
                  ref.read(transferExtProvider.notifier).showBankList(context),
          suffixIcon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 25.ar,
            color: AppColors.textGrey,
          ),
        ),
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
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          suffixOuterTitle: state.recipientAcctName,
          validator: (value) => AppTextValidator.walletNumber(value),
          onChanged: (value) {
            if (value.isNotEmpty && value.length == 10) {
              FocusScope.of(context).unfocus();
              debouncer.run(() async {
                ref.read(transferExtProvider.notifier).validateAcct(value);
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
            ref.read(transferExtProvider.notifier).notifyFormChanged();
          },
          validator:
              (value) => AppTextValidator.minAmount(min: 100, value: value),
          inputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
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
                            .read(transferExtProvider.notifier)
                            .interbankTransfer(pin);
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
