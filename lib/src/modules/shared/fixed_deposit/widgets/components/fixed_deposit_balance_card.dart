import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_dialog_button.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/deposit_providers.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class FixedDepositBalanceCard extends ConsumerWidget {
  const FixedDepositBalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusiness = ref.watch(userIsBusinessProvider);
    //
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringAssets.fixedDepositWalletText,
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _HideFixedDepositBalance()
            ],
          ),
          const FixedDepositBalanceText(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: SavingsDialogButton(
                  onPressed: () {
                    showModalActionSuccess(
                      context: context,
                      title: StringAssets.unavailableText,
                      subtitle: StringAssets.withdrawalsAreUnavailable,
                      onPressed: () {
                        context.pop();
                      },
                    );
                  },
                  textColor: AppColors.rexPurpleDark,
                  title: StringAssets.withdrawal,
                  hasIcon: false,
                  backgroundColor: AppColors.rexBackground,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: SavingsDialogButton(
                  onPressed: () {
                    if (isBusiness) {
                      context.push(
                          "${RouteName.dashboardSaveBusiness}/${RouteName.bizFixedDeposit}");
                    } else {
                      context.push(
                          "${RouteName.dashboardSave}/${RouteName.individualFixedDeposit}");
                    }
                  },
                  textColor: AppColors.rexWhite,
                  hasIcon: false,
                  title: StringAssets.saveTextOnButton,
                  backgroundColor: AppColors.rexPurpleLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FixedDepositBalanceText extends ConsumerWidget {
  const FixedDepositBalanceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideBalance = ref.watch(hideFixedDepositWallet);
    final acctBalance = ref.watch(fetchFixedDepositWalletBalance);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: acctBalance.when(
          data: (balanceEnquiry) {
            if (hideBalance) {
              return const Text(
                "\u20A6******",
                style: AppTextStyles.walletText1,
              );
            }
            if (balanceEnquiry == null) {
              return const Text(
                "\u20A6----}",
                style: AppTextStyles.walletText1,
              );
            } else {
              final numb = NumberFormat.decimalPatternDigits(
                locale: 'en_us',
                decimalDigits: 2,
              ).format(balanceEnquiry.data);
              return Text(
                "\u20A6$numb",
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

class _HideFixedDepositBalance extends ConsumerWidget {
  const _HideFixedDepositBalance();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          'Hide balance',
          style: TextStyle(
            color: AppColors.rexTint600,
            fontSize: 10,
          ),
        ),
        Transform.scale(
          scaleX: 0.7,
          scaleY: 0.6, // Adjust the scale factor to make the switch smaller
          child: Switch.adaptive(
            value: ref.watch(hideFixedDepositWallet),
            onChanged: (bool value) {
              ref.read(hideFixedDepositWallet.notifier).state = value;
            },
          ),
        )
      ],
    );
  }
}
