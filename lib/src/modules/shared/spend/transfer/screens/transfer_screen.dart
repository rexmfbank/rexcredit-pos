import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/beneficiary_detail_widget.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/save_beneficiary_checkbox.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/providers/beneficiary_api_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/providers/internal_account_look_up_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/providers/internal_transfer_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_icon_button.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/transfer_success_bottom_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/extensions/extension_on_object.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

import '../../../../shared/widgets/loading_screen.dart';
import '../../../../shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import '../providers/internal_transfer_provider.dart';

class RexTransferScreen extends StatefulHookConsumerWidget {
  const RexTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransferScreen();
}

class _TransferScreen extends ConsumerState<RexTransferScreen> with LocatorMix {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(billPaymentProvider.notifier).fetchBeneficiaries(
            context,
            TransactionCodes.intraBankTransfer.jsonString,
          );
    });
    super.initState();
  }

  void loadingInit() {
    //
    ref.listen(internalAccountLookUpProvider, (_, state) {
      state.when(
        data: (data) {
          debugPrint("Account LookUp: $data");
          if (data.isNotNull) {
            LoadingScreen.instance().hide();
            ref.read(internalTransferNotifier.notifier).updateBeneficiaryInfo(
                  name: data.data?.name ?? StringAssets.nullString,
                  accountNo: data.data?.accountNumber ??
                      ref
                          .read(internalTransferNotifier)
                          .accountNumberController
                          .text,
                );
          }
        },
        error: (error, stackTrace) {
          LoadingScreen.instance().hide();
          showModalActionError(context: context, errorText: error.toString());
        },
        loading: () => LoadingScreen.instance().show(context: context),
      );
    });
    //
    ref.listen(internalTransferProvider, (_, state) {
      state.when(
        data: (data) {
          LoadingScreen.instance().hide();
          if (context.mounted) {
            showTransferSuccessModal(
              context,
              StringAssets.transferSuccessful,
              StringAssets.transferSuccessfulSubtitle(
                amount: ref
                    .read(internalTransferNotifier)
                    .transferAmountController
                    .text,
                acctName: ref.read(internalTransferNotifier).beneficiaryName,
                bankName: StringAssets.rexMFB,
                accountNumber:
                    ref.read(internalTransferNotifier).beneficiaryAccountNo,
              ),
              transInfo: data.data!,
              onPressed: () {
                context.pop();
              },
            );
          }
        },
        error: (error, stackTrace) {
          LoadingScreen.instance().hide();
          showModalActionError(context: context, errorText: error.toString());
        },
        loading: () => LoadingScreen.instance().show(context: context),
      );
    });
    //
    ref.listen(saveBeneficiaryApiProvider, (_, state) {
      state.when(
        data: (data) {
          LoadingScreen.instance().hide();
          showModalActionSuccess(
            context: context,
            title: StringAssets.beneficiarySavedTitle,
            subtitle: StringAssets.beneficiarySavedSubtitle,
            onPressed: () => context.pop(),
          );
        },
        error: (error, stackTrace) {
          LoadingScreen.instance().hide();
          showModalActionError(context: context, errorText: error.toString());
        },
        loading: () {},
      );
    });
  }

  void handleTransferTypeChanged(String? newValue) {
    // selectedTransferType.value = newValue ?? "";
    debugPrint("AccountType: $newValue");
    ref.read(selectedTransferTypeProvider.notifier).state = newValue ?? "";
    debugPrint(
        "SelectedTransferType: ${ref.read(selectedTransferTypeProvider)}");
  }

  @override
  Widget build(BuildContext context) {
    loadingInit();
    return Form(
      key: ref.watch(internalTransferNotifier).transferFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.aw),
        child: RefreshIndicator(
          color: AppColors.rexPurpleLight,
          onRefresh: () =>
              ref.read(billPaymentProvider.notifier).fetchBeneficiaries(
                    context,
                    TransactionCodes.intraBankTransfer.jsonString,
                  ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              !ref.read(internalTransferNotifier).isSendToNewBeneficiary
                  ? const TransferBeneficiarySearchBar()
                  : const SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.only(top: 24.ah, left: 16.aw, right: 16.aw),
                child: CustomIconButton(
                  onPressed: () => ref
                      .read(internalTransferNotifier.notifier)
                      .toggleNewBeneficiary(),
                  title:
                      !ref.read(internalTransferNotifier).isSendToNewBeneficiary
                          ? StringAssets.sendToNewBeneficiaryTitle
                          : StringAssets.selectBeneficiary,
                  backgroundColor: AppColors.rexPurpleLight,
                  textColor: Colors.white,
                  iconPath: AssetPath.addBeneficiary,
                ),
              ),
              SizedBox(height: 16.ah),
              !ref.read(internalTransferNotifier).isSendToNewBeneficiary
                  ? Builder(
                      builder: (context) {
                        final cleanList = ref
                            .watch(billPaymentProvider)
                            .beneficiaries
                          ?..removeWhere((element) =>
                              element.beneficiaryName.isBlank ||
                              element.beneficiaryAccount.isBlank ||
                              element.tranCode !=
                                  TransactionCodes
                                      .intraBankTransfer.jsonString);
                        var beneficiaries = cleanList ?? [];
                        if (ref.watch(billPaymentProvider).isLoading) {
                          return Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 25.ah,
                              width: 25.aw,
                              child: const CircularProgressIndicator(
                                color: AppColors.rexPurpleLight,
                              ),
                            ),
                          );
                        }
                        if (beneficiaries.isEmpty) {
                          return Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(16.ar),
                              child: Text(
                                StringAssets.noBeneficiariesAvailable,
                                style: AppTextStyles.h2.copyWith(
                                  color: AppColors.rexPurpleLight,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.ar),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.ar),
                                  border: Border.all(
                                    width: 1.aw,
                                    color: AppColors.rexPurpleLight,
                                  )),
                              height: 130.ah,
                              child: Scrollbar(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return BeneficiaryInfoWidget(
                                      beneficiarySelected: ref
                                          .watch(internalTransferNotifier)
                                          .beneficiary,
                                      beneficiaryName: beneficiaries[index]
                                              .beneficiaryName ??
                                          '',
                                      beneficiaryBank: StringAssets.rexMFB,
                                      beneficiaryAccountNumber:
                                          beneficiaries[index]
                                                  .beneficiaryAccount ??
                                              '',
                                      onCheckboxChanged: (value) => {
                                        if (value)
                                          {
                                            ref
                                                .read(internalTransferNotifier
                                                    .notifier)
                                                .updateBeneficiaryInfo(
                                                  name: beneficiaries[index]
                                                          .beneficiaryName ??
                                                      '',
                                                  accountNo: beneficiaries[
                                                              index]
                                                          .beneficiaryAccount ??
                                                      '',
                                                )
                                          }
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10.h);
                                  },
                                  itemCount: beneficiaries.length,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.ah),
                          ],
                        );
                      },
                    )
                  : const SizedBox.shrink(),
              ref.read(internalTransferNotifier).isSendToNewBeneficiary
                  ? RexCustomSpinner(
                      padding: EdgeInsets.zero,
                      options: const [
                        StringAssets.transferToRexMFB,
                      ],
                      title: StringAssets.selectTransferTypeTitle,
                      onOptionChanged: handleTransferTypeChanged,
                    )
                  : Container(),
              SizedBox(height: 8.ah),
              ref.read(internalTransferNotifier).isSendToNewBeneficiary
                  ? RexTextField(
                      horizontalPadding: 0,
                      outerTitle: StringAssets.accountNumberTitle,
                      showOuterTile: true,
                      hintText: StringAssets.accountNumberHint,
                      controller: ref
                          .read(internalTransferNotifier)
                          .accountNumberController,
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      maxLength: 10,
                      validator: (value) => TextfieldValidator.accountNo(value),
                      onChanged: (value) {
                        ref
                            .read(internalTransferNotifier.notifier)
                            .updateBeneficiaryInfo(name: "", accountNo: "");
                        ref
                            .watch(internalTransferNotifier.notifier)
                            .accountNameLookUp();
                      },
                      obscureText: false,
                    )
                  : Container(),
              if (ref.read(internalTransferNotifier).beneficiaryName != "" &&
                  ref
                      .read(internalTransferNotifier)
                      .isSendToNewBeneficiary) ...[
                BeneficiaryNameWidget(
                    beneficiaryName:
                        ref.read(internalTransferNotifier).beneficiaryName),
                AddBeneficiaryCheckbox(
                  isSavedNotifier: ValueNotifier(
                      ref.watch(internalTransferNotifier).addNewBeneficiary),
                  onCheckboxChanged: (value) => ref
                      .watch(internalTransferNotifier.notifier)
                      .toggleAddBeneficiary(value),
                )
              ],
              RexTextField(
                horizontalPadding: 0,
                outerTitle: StringAssets.transferAmountTitle,
                showOuterTile: true,
                hintText: StringAssets.enterAmount,
                inputType: const TextInputType.numberWithOptions(decimal: true),
                hasInputFormat: true,
                controller: ref
                    .watch(internalTransferNotifier)
                    .transferAmountController,
                validator: (value) =>
                    TextfieldValidator.amount(value?.replaceAll(',', '')),
                obscureText: false,
              ),
              RexTextField(
                horizontalPadding: 0,
                outerTitle: StringAssets.narration,
                showOuterTile: true,
                hintText: StringAssets.narrationHint,
                controller:
                    ref.watch(internalTransferNotifier).narrationController,
                obscureText: false,
                maxLength: 160,
              ),
              RexFlatButton(
                onPressed: () => ref
                    .read(internalTransferNotifier.notifier)
                    .validate(context),
                buttonTitle: StringAssets.sendButtonText,
                backgroundColor: null,
              ),
              SizedBox(height: 30.ah),
            ],
          ),
        ),
      ),
    );
  }
}
