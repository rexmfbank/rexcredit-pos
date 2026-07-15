import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_provider.dart';
import 'package:rex_app/src/modules/transfer/widgets/transaction_pin_sheet.dart';
import 'package:rex_app/src/modules/utils/general/app_text_validator.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_bottom_sheet.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class ExternalTransferScreen extends ConsumerStatefulWidget {
  const ExternalTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExternalTransferScreenState();
}

class _ExternalTransferScreenState
    extends ConsumerState<ExternalTransferScreen> {
  final Debouncer debouncer = Debouncer(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transferExtProvider);
    return ListView(
      physics: const BouncingScrollPhysics(),
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
                          .read(transferExtProvider.notifier)
                          .interbankTransfer(v, context);
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

class RexTextFieldCurrencyIcon extends StatelessWidget {
  const RexTextFieldCurrencyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text('${getNairaCurrency(context).currencySymbol}'),
    );
  }
}

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

getNairaCurrency(context) {
  var format = NumberFormat.simpleCurrency(
    locale: Platform.localeName,
    name: 'NGN',
  );
  return format;
}
