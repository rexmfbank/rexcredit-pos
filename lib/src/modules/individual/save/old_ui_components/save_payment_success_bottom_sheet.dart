import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/currency.dart';

void showSavePaymentSuccessModal(
    BuildContext context, int id, String depositAmount) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
        double walletBalance = 0.0;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Lottie.asset('assets/lottiefiles/success_tick.json'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Payment Successful',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'You have successfully funded your savings plan with ${addNairaCurrencySymbol(depositAmount)}.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexTint500,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              RexFlatButton(
                  onPressed: () {
                    // ref
                    //     .read(fetchSavingsDetailProvider.notifier)
                    //     .fetchSavingsDetail(
                    //       authToken: authToken,
                    //       savingsId: id.toString(),
                    //     );
                    context.go(Routes.dashboardSave);
                  },
                  buttonTitle: 'Close',
                  textColor: AppColors.rexWhite,
                  backgroundColor: AppColors.rexPurpleLight)
            ],
          ),
        );
      });
    },
  );
}
