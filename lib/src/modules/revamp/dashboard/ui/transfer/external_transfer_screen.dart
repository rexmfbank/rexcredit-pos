import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/save_transfer_beneficiary_switch.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui_widgets/bank_uptime_card.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui_widgets/beneficiary_account_number.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';

class ExternalTransferScreen extends ConsumerStatefulWidget {
  const ExternalTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExternalTransferScreenState();
}

class _ExternalTransferScreenState
    extends ConsumerState<ExternalTransferScreen> {
  int retryCount = 0;

  setRetryCount() {
    if (retryCount < 3) {
      retryCount++;
      setState(() {});
      ref
          .watch(homeTransferNotifier.notifier)
          .callValidate(
            context,
            ref.watch(homeTransferNotifier).accountNumberController.text,
          );
      setState(() {});
    } else {
      retryCount = 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer(milliseconds: 800);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        BankUptimeCard(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Select Saved Beneficiary'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              ref
                  .watch(homeTransferNotifier.notifier)
                  .showBeneficiaryList2(context);
            },
          ),
        ),
        RexTextField(
          readOnly: true,
          textFieldIsRequired: true,
          outerTitle: 'Select a bank',
          showOuterTile: true,
          hintText: StringAssets.selectBank,
          controller: ref.watch(homeTransferNotifier).bankNameController,
          obscureText: false,
          validator: (value) => TextfieldValidator.input(value),
          onTap:
              () => ref
                  .watch(homeTransferNotifier.notifier)
                  .showBankList(context),
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
          outerTitle: StringAssets.accountNumber,
          hintText: StringAssets.accountNumberHint,
          controller: ref.watch(homeTransferNotifier).accountNumberController,
          obscureText: false,
          inputType: TextInputType.number,
          hasInputFormat: false,
          validator: (value) => TextfieldValidator.walletNumber(value),
          onChanged: (value) {
            if (value.isNotEmpty && value.length == 10) {
              FocusScope.of(context).unfocus();
              debouncer.run(() async {
                ref
                    .read(homeTransferNotifier.notifier)
                    .callValidate(context, value);
              });
            } else {
              debouncer.cancel();
            }
          },
          suffixIcon: Column(
            children: [
              if ((retryCount < 3) &&
                  (ref
                          .watch(homeTransferNotifier)
                          .accountNumberController
                          .text
                          .length ==
                      10) &&
                  (ref.watch(homeTransferNotifier).accountInfo == null) &&
                  (ref.watch(homeTransferNotifier).textAccountName ==
                      "Account Name") &&
                  (ref
                      .watch(homeTransferNotifier)
                      .textAccountName
                      .isEmpty)) ...[
                SizedBox(
                  width: 60,
                  child: IconButton(
                    onPressed: () {
                      setRetryCount();
                    },
                    icon: Icon(Icons.replay_outlined),
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppColors.rexWhite,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(ref.watch(homeTransferNotifier).textAccountName),
                ),
              ),
            ],
          ),
        ),
        const SaveTransferBeneficiarySwitch(),
        SizedBox(height: 4.ah),
        RexTextField(
          prefixIcon: const RexTextFieldCurrencyIcon(),
          outerTitle: 'Transfer amount',
          textFieldIsRequired: true,
          showOuterTile: true,
          hintText: 'Enter amount',
          controller: ref.watch(homeTransferNotifier).amountController,
          obscureText: false,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          hasInputFormat: true,
          validator:
              (value) =>
                  TextfieldValidator.minAmount(minAmount: 50, value: value),
          inputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'\d')),
            AmountTextInputFormatter(),
          ],
        ),
        SizedBox(height: 4.ah),
        RexTextField(
          outerTitle: StringAssets.narration,
          hintText: 'Add a narration',
          controller: ref.watch(homeTransferNotifier).narrationController,
          obscureText: false,
          inputType: TextInputType.text,
          hasInputFormat: false,
          maxLength: 160,
        ),
        SizedBox(height: 15.ah),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw),
          child: RexFlatButton(
            onPressed:
                () => ref
                    .watch(homeTransferNotifier.notifier)
                    .validateTransferCall(context),
            buttonTitle: StringAssets.confirmTextOnButton,
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
