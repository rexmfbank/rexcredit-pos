import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/saved_cards_layout.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/currency.dart';

class PayWithRex extends HookConsumerWidget {
  final bool isLoading;
  final bool isTopUp;
  final double amountToPay;
  final int id;
  final String nubanBalanceString;
  final bool hasSufficientBalance;

  const PayWithRex(
      {super.key,
      required this.isTopUp,
      required this.isLoading,
      required this.amountToPay,
      required this.id,
      required this.hasSufficientBalance,
      required this.nubanBalanceString});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.rexTint300,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            top: 22,
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pay from REX Account",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexPurpleDark,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.rexTint500,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account balance",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.rexTint500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  !isLoading
                      ? Text(
                          addNairaCurrencySymbol(nubanBalanceString),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppColors.rexPurpleDark,
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: SizedBox(
                            height: 12,
                            width: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.rexPurpleDark),
                            ),
                          ),
                        ),
                ],
              ),
              !hasSufficientBalance
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "You have an insufficient balance",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    )
                  : Container(
                      height: 6,
                    ),
              !hasSufficientBalance
                  ? SizedBox(
                      width: double.infinity,
                      child: RexFlatButton(
                        onPressed: () {
                          showTopUpModalSheet(context: context);
                        },
                        buttonTitle: "Top Up Account",
                        backgroundColor: AppColors.rexPurpleDark,
                      ),
                    )
                  : Container(
                      height: 4,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
