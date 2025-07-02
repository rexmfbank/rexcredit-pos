import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/widgets/service_provider_item.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/biller_categories.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../shared/widgets/save_beneficiary_toggle.dart';
import '../provider/airtime_provider.dart';

class AirtimeBuyTab extends ConsumerStatefulWidget {
  const AirtimeBuyTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AirtimeBuyTabState();
}

class _AirtimeBuyTabState extends ConsumerState<AirtimeBuyTab>
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
    super.build(context);
    final state = ref.watch(billPaymentProvider);
    final billers = state.airtimeBillers?.billers ?? [];

    ref.listen(airtimeProvider, (previous, next) {
      if (next.formError != null && next.formError.isNotBlank) {
        context.showToast(message: next.formError!);
        ref.watch(airtimeProvider.notifier).clearFormError();
      }
    });

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(billPaymentProvider.notifier)
            .fetchAllBillers(context, BillerCategories.airtime);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            RexTextField(
              horizontalPadding: 0.0,
              showOuterTile: true,
              outerTitle: StringAssets.phoneNumberTitle,
              hintText: '',
              controller: ref.watch(airtimeProvider).phoneNumberController,
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
                                .watch(airtimeProvider)
                                .selectedServiceProvider
                                ?.billerCode ==
                            billers[index].billerCode,
                        onTap: () {
                          ref
                              .read(airtimeProvider.notifier)
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
            RexTextField(
              horizontalPadding: 0.0,
              showOuterTile: true,
              outerTitle: StringAssets.amount,
              hintText: '',
              controller: ref.watch(airtimeProvider).amountController,
              inputType: TextInputType.number,
              validator: (value) => TextfieldValidator.amount(value),
            ),
            SizedBox(height: 15.h),
            SaveBeneficiaryToggle(
              value: ref.watch(airtimeProvider).isBeneficiary,
              onChanged: (value) {
                ref.read(airtimeProvider.notifier).setIsBeneficiary(value);
              },
            ),
            SizedBox(height: 15.h),
            RexFlatButton(
              onPressed: () {
                ref.read(airtimeProvider.notifier).validateAirtime(context);
              },
              buttonTitle: StringAssets.nextTextOnButton,
              backgroundColor: null,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
