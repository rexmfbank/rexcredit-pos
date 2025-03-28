import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/widgets/save_beneficiary_toggle.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/widgets/service_provider_item.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../shared/widgets/app_rex_text_field.dart';
import '../provider/data_provider.dart';

class DataNewPaymentTab extends ConsumerStatefulWidget {
  const DataNewPaymentTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DataNewPaymentTabState();
}

class _DataNewPaymentTabState extends ConsumerState<DataNewPaymentTab>
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
    final state = ref.watch(billPaymentProvider);
    final billers = state.dataBillers ?? [];

    ref.listen(billPaymentDataProvider, (previous, next) {
      if (next.formError != null && next.formError.isNotBlank) {
        context.showToast(message: next.formError!);
        ref.watch(billPaymentDataProvider.notifier).clearFormError();
      }
    });

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(billPaymentProvider.notifier)
            .fetchAllBillers(context, BillerCategories.data);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AppRexTextField(
              outerTitle: StringAssets.phoneNumberTitle,
              hintText: '',
              controller:
                  ref.watch(billPaymentDataProvider).phoneNumberController,
              inputType: TextInputType.phone,
              maxLength: 11,
              validator: (value) => TextfieldValidator.phoneNumber(value),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                const Text(
                  StringAssets.networkProvider,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: AppColors.rexBlack,
                  ),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ServiceProviderItem(
                        isSelected: ref
                                .watch(billPaymentDataProvider)
                                .selectedServiceProvider
                                ?.billerCode ==
                            billers[index].billerCode,
                        onTap: () {
                          ref
                              .read(billPaymentDataProvider.notifier)
                              .setSelectedServiceProvider(billers[index]);
                        },
                        biller: billers[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 15.w);
                    },
                    itemCount: billers.length,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            AppRexTextField(
              outerTitle: StringAssets.selectDataPlan,
              hintText: '',
              controller: ref.watch(billPaymentDataProvider).dataPlanController,
              inputType: TextInputType.none,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                size: 24,
              ),
              onTap: () {
                ref
                    .read(billPaymentDataProvider.notifier)
                    .showDataPlan(context);
              },
            ),
            SizedBox(height: 15.h),
            AppRexTextField(
              outerTitle: StringAssets.amount,
              hintText: '',
              controller: ref.watch(billPaymentDataProvider).amountController,
              readOnly: true,
              inputType: TextInputType.none,
              validator: (value) => TextfieldValidator.amount(value),
            ),
            SizedBox(height: 15.h),
            SaveBeneficiaryToggle(
                value: ref.watch(billPaymentDataProvider).isBeneficiary,
                onChanged: (value) {
                  ref
                      .read(billPaymentDataProvider.notifier)
                      .setIsBeneficiary(value);
                }),
            SizedBox(height: 15.h),
            RexFlatButton(
              onPressed: () {
                ref
                    .read(billPaymentDataProvider.notifier)
                    .validateData(context);
              },
              buttonTitle: StringAssets.nextTextOnButton,
              backgroundColor: null,
            ),
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }
}
