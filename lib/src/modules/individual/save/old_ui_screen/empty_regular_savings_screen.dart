import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmptyRegularSavingsScreen extends StatelessWidget {
  const EmptyRegularSavingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Lottie.asset('assets/lottiefiles/saving_money.json'),
          ),
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                StringAssets.zeroStateSavingsTitle2,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.rexPurpleLight,
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
                StringAssets.zeroStateSavingsSubtitle,
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
              top: 20.0,
              left: 104.0,
              right: 104.0,
            ),
            child: RexFlatButton(
              onPressed: () {
                context.push('${Routes.dashboardSave}/');
              },
              buttonTitle: StringAssets.createSavingsTextOnButton,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
