import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/provider_bills/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class TransferBeneficiarySearchBar extends ConsumerWidget {
  const TransferBeneficiarySearchBar({
    super.key,
    this.hintText = 'Find beneficiary',
  });

  final String? hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexSearchField(
      hint: hintText ?? '',
      controller: ref.watch(billPaymentProvider).searchBeneficiaryController,
      onChanged:
          (value) =>
              ref.watch(billPaymentProvider.notifier).searchAction(context),
      onEditingComplete:
          (value) => ref
              .watch(billPaymentProvider.notifier)
              .searchBeneficiaries(context: context, query: value),
      hintStyle: AppTextStyles.body2Regular.copyWith(
        color: AppColors.rexTint500,
        fontSize: 13.asp,
      ),
      enabledBorderColor: AppColors.rexWhite,
      borderRadius: 15.ar,
    );
  }
}
