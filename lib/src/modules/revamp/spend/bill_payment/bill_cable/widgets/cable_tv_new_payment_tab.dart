import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_cable/provider/cable_tv_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/app_rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../utils/config/theme/app_colors.dart';
import '../../../../../../utils/debouncer.dart';
import '../../../../../shared/models/text_field_validator.dart';
import '../../shared/widgets/save_beneficiary_toggle.dart';
import '../../shared/widgets/service_provider_item.dart';
import '../../shared/providers/bill_payment_provider.dart';

class CableTvNewPaymentTab extends ConsumerStatefulWidget {
  const CableTvNewPaymentTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CableTvNewPaymentTabState();
}

class _CableTvNewPaymentTabState extends ConsumerState<CableTvNewPaymentTab>
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

    ref.listen(cableTvProvider, (previous, next) {
      if (next.formError != null && next.formError.isNotBlank) {
        context.showToast(message: next.formError!);
        ref.watch(cableTvProvider.notifier).clearFormError();
      }
    });

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.ah),
          Text(
            StringAssets.selectBiller,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColors.rexBlack,
            ),
          ),
          SizedBox(height: 15.ah),
          const BillerListBuilder(),
          SizedBox(height: 15.ah),
          AppRexTextField(
            outerTitle: StringAssets.selectBouquetPlan,
            hintText: '',
            controller: ref.watch(cableTvProvider).bouquetPlanController,
            inputType: TextInputType.none,
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 24,
            ),
            onTap: () {
              ref.read(cableTvProvider.notifier).showBouquetPlan(context);
            },
          ),
          SizedBox(height: 15.ah),
          AppRexTextField(
            outerTitle: StringAssets.amount,
            hintText: '',
            controller: ref.watch(cableTvProvider).amountController,
            readOnly: true,
            inputType: TextInputType.none,
            validator: (value) => TextfieldValidator.amount(value),
          ),
          SizedBox(height: 15.ah),
          AppRexTextField(
            outerTitle: StringAssets.enterSmartCardNumber,
            hintText: '',
            controller: ref.watch(cableTvProvider).smartCardNumberController,
            inputType: TextInputType.number,
            validator: (value) => TextfieldValidator.smartCardNo(value),
            onChanged: (value) {
              if (value.length > 9) {
                debouncer.run(() {
                  ref.read(cableTvProvider.notifier).resetApiError();
                  ref
                      .read(cableTvProvider.notifier)
                      .validateSmartCardNo(context);
                });
              }
            },
          ),
          SizedBox(height: 3.ah),
          const CustomerNameBuilder(),
          SizedBox(height: 15.ah),
          SaveBeneficiaryToggle(
              value: ref.watch(cableTvProvider).isBeneficiary,
              onChanged: (value) {
                ref.read(cableTvProvider.notifier).setIsBeneficiary(value);
              }),
          SizedBox(height: 15.ah),
          RexElevatedButton(
            onPressed: () {
              ref.read(cableTvProvider.notifier).resetApiError();
              ref.read(cableTvProvider.notifier).validateCableTv(context);
            },
            buttonTitle: StringAssets.nextTextOnButton,
            backgroundColor: null,
          ),
        ],
      ),
    );
  }
}

class BillerListBuilder extends ConsumerWidget {
  const BillerListBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billPaymentProvider);
    final billers = state.cableBillers ?? [];

    return SizedBox(
      height: 60.ah,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ServiceProviderItem(
            isSelected: ref
                    .watch(cableTvProvider)
                    .selectedServiceProvider
                    ?.billerCode ==
                billers[index].billerCode,
            onTap: () {
              ref
                  .read(cableTvProvider.notifier)
                  .setSelectedServiceProvider(billers[index]);
            },
            biller: billers[index],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 15.aw);
        },
        itemCount: billers.length,
      ),
    );
  }
}

class CustomerNameBuilder extends ConsumerWidget {
  const CustomerNameBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cableTvProvider);

    return Align(
      alignment: Alignment.topRight,
      child: state.validateSmartCardNoLoading
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
                  style: TextStyle(
                    color: AppColors.rexPurpleLight,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                )
              : const SizedBox.shrink(),
    );
  }
}
