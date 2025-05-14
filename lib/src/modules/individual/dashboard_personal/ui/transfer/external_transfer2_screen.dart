import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/save_transfer_beneficiary_switch.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/bank_uptime_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ExternalTransfer2Screen extends ConsumerStatefulWidget {
  const ExternalTransfer2Screen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExternalTransfer2ScreenState();
}

class _ExternalTransfer2ScreenState
    extends ConsumerState<ExternalTransfer2Screen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Select Saved Beneficiary'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              ref
                  .watch(homeTransferNotifier.notifier)
                  .showBeneficiaryList2(context);
            },
          ),
        ),
        RexTextField(
          readOnly: true,
          outerTitle: StringAssets.bank,
          hintText: StringAssets.selectBank,
          controller: ref.watch(homeTransferNotifier).bankNameController,
          obscureText: false,
          validator: (value) => TextfieldValidator.input(value),
          onTap: () =>
              ref.watch(homeTransferNotifier.notifier).showBankList(context),
          suffixIcon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 25.ar,
            color: AppColors.textGrey,
          ),
        ),
        RexTextField(
          maxLength: 10,
          outerTitle: StringAssets.accountNumber,
          hintText: StringAssets.accountNumberHint,
          controller: ref.watch(homeTransferNotifier).accountNumberController,
          obscureText: false,
          inputType: TextInputType.number,
          hasInputFormat: false,
          validator: (value) => TextfieldValidator.walletNumber(value),
          onChanged: (value) => ref
              .watch(homeTransferNotifier.notifier)
              .callValidate(context, value),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppColors.rexWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ref.watch(homeTransferNotifier).textAccountName,
            ),
          ),
        ),
        const SaveTransferBeneficiarySwitch(),
        SizedBox(height: 4.ah),
        RexTextField(
          prefixIcon: const RexTextFieldCurrencyWidget(),
          outerTitle: StringAssets.amount,
          hintText: StringAssets.savingsPlanTargetAmountHint,
          controller: ref.watch(homeTransferNotifier).amountController,
          obscureText: false,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          hasInputFormat: true,
          validator: (value) => TextfieldValidator.minAmount(
            minAmount: 5,
            value: value,
          ),
        ),
        SizedBox(height: 4.ah),
        RexTextField(
          outerTitle: StringAssets.narration,
          hintText: StringAssets.narration,
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
            onPressed: () => ref
                .watch(homeTransferNotifier.notifier)
                .validateTransferCall(context),
            buttonTitle: StringAssets.confirmTextOnButton,
            backgroundColor: null,
          ),
        ),
        SizedBox(height: 10.ah),
        // const Align(
        //   alignment: Alignment.center,
        //   child: BankUptimeCard(),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(StringAssets.uptimeCardText),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              context
                  .push("${Routes.dashboardIndividual}/${Routes.bankUptime}");
            },
          ),
        ),
      ],
    );
  }
}
