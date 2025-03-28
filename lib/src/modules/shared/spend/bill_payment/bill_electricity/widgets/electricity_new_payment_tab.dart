import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/widgets/select_biller_modal_sheet.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/widgets/select_meter_type_modal_sheet.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/provider/electricity_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../../config/theme/app_colors.dart';
import '../../../../../../utils/debouncer.dart';
import '../../../../../shared/models/text_field_validator.dart';
import '../../../../../shared/widgets/app_rex_text_field.dart';
import '../../shared/widgets/save_beneficiary_toggle.dart';

class ElectricityNewPaymentTab extends ConsumerStatefulWidget {
  const ElectricityNewPaymentTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ElectricityNewPaymentTabState();
}

class _ElectricityNewPaymentTabState
    extends ConsumerState<ElectricityNewPaymentTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    return;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(delay: 500);

    ref.listen(electricityProvider, (previous, next) {
      if (next.formError != null && next.formError.isNotBlank) {
        context.showToast(message: next.formError!);
        ref.watch(electricityProvider.notifier).clearFormError();
      }
    });

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          AppRexTextField(
            outerTitle: StringAssets.selectBiller,
            controller: ref.watch(electricityProvider).billerNameController,
            inputType: TextInputType.none,
            readOnly: true,
            isRequired: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 24,
            ),
            onTap: () {
              showSelectBillerModal(context);
            },
          ),
          SizedBox(height: 10.ah),
          AppRexTextField(
            outerTitle: StringAssets.selectMeterType,
            controller: ref.watch(electricityProvider).meterTypeController,
            inputType: TextInputType.none,
            readOnly: true,
            isRequired: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 24,
            ),
            onTap: () {
              showSelectMeterTypeModal(context);
            },
          ),
          SizedBox(height: 15.ah),
          AppRexTextField(
            outerTitle: StringAssets.enterMeterNumber,
            controller: ref.watch(electricityProvider).meterNumberController,
            isRequired: true,
            validator: (value) => TextfieldValidator.meterNo(value),
            inputType: TextInputType.number,
            maxLength: 16,
            onChanged: (value) {
              if (value.length > 8) {
                debouncer.run(() {
                  ref.read(electricityProvider.notifier).resetApiError();
                  ref
                      .read(electricityProvider.notifier)
                      .validateMeterNo(context);
                });
              }
            },
          ),
          SizedBox(height: 3.ah),
          const CustomerNameBuilder(),
          SizedBox(height: 15.ah),
          AppRexTextField(
            outerTitle: StringAssets.amount,
            controller: ref.watch(electricityProvider).amountController,
            inputType: TextInputType.number,
            validator: (value) => TextfieldValidator.minAmount(
              value: value,
              minAmount: ref
                      .watch(electricityProvider)
                      .selectedBillerProduct
                      ?.minAmount ??
                  200,
            ),
          ),
          SizedBox(height: 15.ah),
          SaveBeneficiaryToggle(
              value: ref.watch(electricityProvider).isBeneficiary,
              onChanged: (value) {
                ref.read(electricityProvider.notifier).setIsBeneficiary(value);
              }),
          SizedBox(height: 20.ah),
          RexElevatedButton(
            onPressed: () {
              ref
                  .read(electricityProvider.notifier)
                  .validateElectricity(context);
            },
            buttonTitle: StringAssets.nextTextOnButton,
            backgroundColor: null,
          ),
        ],
      ),
    );
  }
}

class CustomerNameBuilder extends ConsumerWidget {
  const CustomerNameBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(electricityProvider);

    return Align(
      alignment: Alignment.topRight,
      child: state.validateMeterNoLoading
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.aw),
              child: SizedBox(
                height: 5.ah,
                width: 5.aw,
                child: CircularProgressIndicator(strokeWidth: 2.aw),
              ),
            )
          : (state.validateBillData?.customerName.isNotBlank == true)
              ? Text(
                  state.validateBillData?.customerName ?? '',
                  style: AppTextStyles.body2Regular.copyWith(
                    color: AppColors.rexPurpleLight,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : const SizedBox.shrink(),
    );
  }
}
