import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/provider_bills/bill_payment_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/components/save_beneficiary_checkbox.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/beneficiary_api_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_account_look_up_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_transfer_notifier.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/widgets/beneficiary_account_number.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/widgets/beneficiary_name_widget.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/widgets/beneficiary_select_type.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/widgets/beneficiary_toggle.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/widget/app_bottom_sheet.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/transfer_success_bottom_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/extensions/extension_on_object.dart';
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
      ref
          .read(billPaymentProvider.notifier)
          .fetchBeneficiaries(
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
            ref
                .read(internalTransferNotifier.notifier)
                .updateBeneficiaryInfo(
                  name: data.data?.name ?? StringAssets.nullString,
                  accountNo:
                      data.data?.accountNumber ??
                      ref
                          .watch(internalTransferNotifier)
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
    //-----> Internal Transfer Beneficiary
    ref.listen(internalTransferProvider, (_, state) {
      state.when(
        data: (data) {
          LoadingScreen.instance().hide();
          if (context.mounted) {
            showTransferSuccessModal(
              context,
              StringAssets.transferSuccessful,
              StringAssets.transferSuccessfulSubtitle(
                amount:
                    ref
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
                context.go(Routes.dashboardIndividual);
              },
            );
          }
        },
        error: (error, stackTrace) {
          LoadingScreen.instance().hide();
          if (error is AccountLockException) {
            context.showToast(
              message: 'Account locked after multiple failed attempts',
            );
            context.go(Routes.login);
          } else {
            context.showToast(message: error.toString());
          }
        },
        loading: () => LoadingScreen.instance().show(context: context),
      );
    });
    //-----> Save Beneficiary
    ref.listen(saveBeneficiaryApiProvider, (_, state) {
      state.when(
        data: (data) {
          LoadingScreen.instance().hide();
          context.showToast(message: StringAssets.beneficiarySavedSubtitle);
          context.pop();
        },
        error: (error, stackTrace) {
          LoadingScreen.instance().hide();
          context.showToast(message: error.toString());
        },
        loading: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(billPaymentProvider);
    loadingInit();
    return Form(
      key: ref.watch(internalTransferNotifier).transferFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.aw),
        child: RefreshIndicator(
          color: AppColors.rexPurpleLight,
          onRefresh:
              () => ref
                  .read(billPaymentProvider.notifier)
                  .fetchBeneficiaries(
                    context,
                    TransactionCodes.intraBankTransfer.jsonString,
                  ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // BeneficiarySearchBar(),
              BeneficiaryToggle(
                onPressed: () {
                  AppBottomSheet.showDraggableBottomsheet(
                    context,
                    useRootNavigator: false,
                    widget: SelectRexBeneficiarySheet(),
                  );
                },
              ),

              SizedBox(height: 16.ah),
              // BeneficiaryInfo(
              //   ancestorWIdget: context,
              // ),
              // end of beneficiary info
              BeneficiarySelectType(),
              SizedBox(height: 8.ah),

              Visibility(
                visible:
                    ref.watch(internalTransferNotifier).beneficiaryName == "",
                child: BeneficiaryAccountNumber(),
              ),

              Visibility(
                visible:
                    ref.watch(internalTransferNotifier).beneficiaryName != "",
                child: BeneficiaryNameWidget(
                  title:
                      ref.watch(internalTransferNotifier).isSendToBeneficiary
                          ? null
                          : "Recipient name",
                  beneficiaryName:
                      ref.watch(internalTransferNotifier).beneficiaryName,
                  onTap: () {
                    if (ref
                        .watch(internalTransferNotifier)
                        .isSendToBeneficiary) {
                      ref
                          .read(internalTransferNotifier.notifier)
                          .toggleBeneficiary();
                    }

                    ref
                        .read(internalTransferNotifier.notifier)
                        .clearBeneficiary();
                  },
                ),
              ),

              Visibility(
                visible:
                    !ref.watch(internalTransferNotifier).isSendToBeneficiary,
                child: AddBeneficiaryCheckbox(
                  isSavedNotifier: ValueNotifier(
                    ref.watch(internalTransferNotifier).addNewBeneficiary,
                  ),
                  onCheckboxChanged:
                      (value) => ref
                          .watch(internalTransferNotifier.notifier)
                          .toggleAddBeneficiary(value),
                ),
              ),

              RexTextField(
                horizontalPadding: 0,
                outerTitle: StringAssets.transferAmountTitle,
                showOuterTile: true,
                hintText: StringAssets.enterAmount,
                inputType: const TextInputType.numberWithOptions(decimal: true),
                hasInputFormat: true,
                controller:
                    ref
                        .watch(internalTransferNotifier)
                        .transferAmountController,
                validator:
                    (value) => TextfieldValidator.minAmount(
                      minAmount: 50,
                      value: value,
                    ),
                obscureText: false,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d')),
                  AmountTextInputFormatter(),
                ],
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
                textInputAction: TextInputAction.done,
              ),
              RexFlatButton(
                onPressed:
                    () => ref
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

class SelectRexBeneficiarySheet extends ConsumerStatefulWidget {
  const SelectRexBeneficiarySheet({super.key});

  @override
  ConsumerState<SelectRexBeneficiarySheet> createState() =>
      _SelectRexBeneficiarySheetState();
}

class _SelectRexBeneficiarySheetState
    extends ConsumerState<SelectRexBeneficiarySheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(billPaymentProvider.notifier)
          .fetchBeneficiaries(
            context,
            TransactionCodes.intraBankTransfer.jsonString,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final beneficiary = ref.watch(billPaymentProvider).beneficiaries;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // BeneficiarySearchBar(),
          SizedBox(height: 20),

          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Select Beneficiary",
                  style: AppTextStyles.body2Regular.copyWith(
                    color: AppColors.cardGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.asp,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.pop(this.context),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 20),
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: beneficiary?.length ?? 0,
              itemBuilder: (context, index) {
                final value = beneficiary?[index];
                return BeneficiaryCell(
                  onDelete: () {
                    ref
                        .read(billPaymentProvider.notifier)
                        .deleteBeneficiaries(
                          this.context,
                          TransactionCodes.intraBankTransfer.jsonString,
                          value?.id ?? '',
                          onSuccess: () {
                            ref
                                .read(billPaymentProvider.notifier)
                                .fetchBeneficiaries(
                                  context,
                                  TransactionCodes.intraBankTransfer.jsonString,
                                );
                          },
                        );
                  },
                  beneficiarySelected:
                      ref.watch(internalTransferNotifier).beneficiary,
                  beneficiaryName: value?.beneficiaryName ?? '',
                  beneficiaryBank: StringAssets.rexMFB,
                  beneficiaryAccountNumber: value?.beneficiaryAccount ?? '',
                  onTap: () {
                    Navigator.pop(this.context);
                    ref
                        .read(internalTransferNotifier.notifier)
                        .accountNumberController();

                    ref
                        .read(internalTransferNotifier.notifier)
                        .toggleBeneficiary();
                    ref
                        .read(internalTransferNotifier.notifier)
                        .updateBeneficiaryInfo(
                          name: value?.beneficiaryName ?? "",
                          accountNo: value?.beneficiaryAccount ?? '',
                        );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
    );
  }
}
