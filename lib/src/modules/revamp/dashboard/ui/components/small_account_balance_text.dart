import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class SmallAccountBalanceText extends ConsumerWidget {
  const SmallAccountBalanceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAcctBalance = ref.watch(userAcctBalanceProvider);
    final hideAccount = ref.watch(hideAccountProvider);
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: userAcctBalance.when(
        data: (balanceEnquiry) {
          if (hideAccount) {
            return Text(
              "Balance: \u20A6******",
              style: AppTextStyles.body3Regular.copyWith(
                height: 1.8,
                fontWeight: FontWeight.w800,
                color: AppColors.cardGrey.withOpacity(0.7),
              ),
            );
          }
          if (balanceEnquiry.data == null) {
            return Text(
              "Balance: \u20A6----}",
              style: AppTextStyles.body3Regular.copyWith(
                height: 1.8,
                fontWeight: FontWeight.w800,
                color: AppColors.cardGrey.withOpacity(0.7),
              ),
            );
          } else {
            return Text(
              'Balance: ${balanceEnquiry.data!.availableBalance.formatCurrencyNum()}',
              style: AppTextStyles.body3Regular.copyWith(
                height: 1.8,
                fontWeight: FontWeight.w800,
                color: AppColors.cardGrey.withOpacity(0.7),
              ),
            );
          }
        },
        error:
            (error, stack) => Text(
              "\u20A6....",
              style: AppTextStyles.body3Regular.copyWith(
                height: 1.8,
                fontWeight: FontWeight.w800,
                color: AppColors.cardGrey.withOpacity(0.7),
              ),
            ),
        loading: () => AppTextStyles.placeholderNairaText,
      ),
    );
  }
}
