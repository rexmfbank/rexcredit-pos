import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:lottie/lottie.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 55),
        SizedBox(
          height: 200,
          child: Lottie.asset('assets/lottiefiles/investment_icon.json'),
        ),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              StringAssets.zeroStateInvestmentTitle,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexBlue,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 56.0, right: 56.0),
            child: Text(
              StringAssets.zeroStateInvestmentSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.rexTint500,
                height: 1.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 104.0,
            right: 104.0,
          ),
          child: RexFlatButton(
            onPressed: () {
              context.push('${Routes.dashboardSave}/');
            },
            buttonTitle: 'Start Investing',
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
