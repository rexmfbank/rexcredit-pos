import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/SelectedBeneficiaryTile.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/save_transfer_beneficiary_switch.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardHomeTransferScreen extends StatefulHookConsumerWidget {
  const DashboardHomeTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardHomeTransferScreenState();
}

class _DashboardHomeTransferScreenState
    extends ConsumerState<DashboardHomeTransferScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeTransferNotifier.notifier).getListOfBanks(context);
      ref.read(homeTransferNotifier.notifier).fetchBeneficiaries(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      isLoading: ref.watch(homeTransferNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.transferMoney,
        subtitle: StringAssets.toRexAccountOrOthers,
      ),
      body: Form(
        key: ref.watch(homeTransferNotifier).formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 14.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexFlatButton(
                onPressed: () => ref
                    .watch(homeTransferNotifier.notifier)
                    .toggleSendToNewBeneficiary(),
                buttonTitle:
                    ref.watch(homeTransferNotifier).sendToNewBeneficiary
                        ? StringAssets.selectBeneficiary
                        : StringAssets.sendToNewBeneficiaryTitle,
                backgroundColor: null,
              ),
            ),
            SizedBox(height: 14.ah),
            if (!ref.watch(homeTransferNotifier).sendToNewBeneficiary &&
                ref.watch(homeTransferNotifier).selectedBeneficiary != null &&
                ref
                        .watch(homeTransferNotifier)
                        .selectedBeneficiary!
                        .beneficiaryName !=
                    null) ...[
              const SelectedBeneficiaryTile(),
            ],
            SizedBox(height: 4.ah),
            Visibility(
              visible: !ref.watch(homeTransferNotifier).sendToNewBeneficiary,
              child: Padding(
                padding: EdgeInsets.only(left: 16.aw),
                child: InkWell(
                  onTap: () => ref
                      .watch(homeTransferNotifier.notifier)
                      .showBeneficiaryList(context),
                  child: Text(
                    StringAssets.selectBeneficiary,
                    style: AppTextStyles.body2Regular.copyWith(
                      color: AppColors.softBlue,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.ah),
            Visibility(
              visible: ref.watch(homeTransferNotifier).sendToNewBeneficiary,
              child: RexTextField(
                readOnly: true,
                outerTitle: StringAssets.bank,
                hintText: StringAssets.selectBank,
                controller: ref.watch(homeTransferNotifier).bankNameController,
                obscureText: false,
                validator: (value) => TextfieldValidator.input(value),
                onTap: () => ref
                    .watch(homeTransferNotifier.notifier)
                    .showBankList(context),
                suffixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 25.ar,
                  color: AppColors.textGrey,
                ),
              ),
            ),
            SizedBox(height: 4.ah),
            Visibility(
              visible: (ref.watch(homeTransferNotifier).bankSelected &&
                      ref.watch(homeTransferNotifier).sendToNewBeneficiary) ||
                  (ref.watch(homeTransferNotifier).selectedBeneficiary !=
                          null &&
                      ref
                              .watch(homeTransferNotifier)
                              .selectedBeneficiary!
                              .beneficiaryName !=
                          null &&
                      !ref.watch(homeTransferNotifier).sendToNewBeneficiary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible:
                        ref.watch(homeTransferNotifier).sendToNewBeneficiary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RexTextField(
                          maxLength: 10,
                          outerTitle: StringAssets.accountNumber,
                          hintText: StringAssets.accountNumberHint,
                          controller: ref
                              .watch(homeTransferNotifier)
                              .accountNumberController,
                          obscureText: false,
                          inputType: TextInputType.number,
                          hasInputFormat: false,
                          validator: (value) =>
                              TextfieldValidator.walletNumber(value),
                          onChanged: (value) => ref
                              .watch(homeTransferNotifier.notifier)
                              .callValidate(context, value),
                        ),
                        SizedBox(height: 4.ah),
                        Builder(
                          builder: (context) {
                            if (ref
                                .watch(homeTransferNotifier)
                                .accountValidating) {
                              return const Center(
                                child: Text(
                                  StringAssets.validatingAccount,
                                ),
                              );
                            }
                            return RexTextField(
                              outerTitle: StringAssets.accountName,
                              hintText: StringAssets.accountName,
                              controller: ref
                                  .watch(homeTransferNotifier)
                                  .acctNameController,
                              errorText: ref
                                  .watch(homeTransferNotifier)
                                  .accountNameError,
                              obscureText: false,
                              readOnly: true,
                            );
                          },
                        ),
                        const SaveTransferBeneficiarySwitch(),
                        SizedBox(height: 4.ah),
                      ],
                    ),
                  ),
                  RexTextField(
                    prefixIcon: const RexTextFieldCurrencyWidget(),
                    outerTitle: StringAssets.amount,
                    hintText: StringAssets.savingsPlanTargetAmountHint,
                    controller:
                        ref.watch(homeTransferNotifier).amountController,
                    obscureText: false,
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
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
                    controller:
                        ref.watch(homeTransferNotifier).narrationController,
                    obscureText: false,
                    inputType: TextInputType.text,
                    hasInputFormat: false,
                    maxLength: 160,
                  ),
                  SizedBox(height: 104.ah),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          SizedBox(height: 30.ah),
        ],
      ),
    );
  }
}
