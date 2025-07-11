import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class AccountBalanceText extends ConsumerWidget {
  const AccountBalanceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAcctBalance = ref.watch(userAcctBalanceProvider);
    final hideAccount = ref.watch(hideAccountProvider);
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: userAcctBalance.when(
          data: (balanceEnquiry) {
            if (hideAccount) {
              return const Text(
                "\u20A6******",
                style: AppTextStyles.walletText1,
              );
            }
            if (balanceEnquiry.data == null) {
              return const Text(
                "\u20A6----}",
                style: AppTextStyles.walletText1,
              );
            } else {
              return Text(
                balanceEnquiry.data!.availableBalance.formatCurrencyNum(),
                style: AppTextStyles.walletText1,
              );
            }
          },
          error: (error, stack) => AppTextStyles.placeholderNairaText,
          loading: () => AppTextStyles.placeholderNairaText,
        ),
      ),
    );
  }
}
