import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_provider.dart';
import 'package:rex_app/src/modules/transfer/widgets/currency_icon.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/general/app_text_validator.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';

class TransferExternalTab extends ConsumerStatefulWidget {
  const TransferExternalTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransferExternalTabState();
}

class _TransferExternalTabState extends ConsumerState<TransferExternalTab> {
  final Debouncer debouncer = Debouncer(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
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
          suffixOuterTitle: state.recipientAcctName,
          validator: (value) => AppTextValidator.walletNumber(value),
          onChanged: (value) {
            if (value.isNotEmpty && value.length == 10) {
              FocusScope.of(context).unfocus();
              debouncer.run(() async {
                ref
                    .read(transferExtProvider.notifier)
                    .validateAcct(context, value);
              });
            } else {
              debouncer.cancel();
            }
          },
        ),
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
        SizedBox(height: 10.ah),
      ],
    );
  }
}
