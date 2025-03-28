import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TargetSavingsEmpty extends ConsumerWidget {
  const TargetSavingsEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusiness = ref.watch(userIsBusinessProvider);
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
              StringAssets.zeroStateSavingsTitle2,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.rexBlue,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 56.0, right: 56.0),
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
            top: 30.0,
            left: 104.0,
            right: 104.0,
          ),
          child: RexFlatButton(
            onPressed: () {
              if (isBusiness) {
                context.push(
                    "${RouteName.dashboardSaveBusiness}/${RouteName.bizTargetSaving}");
              } else {
                context.push(
                    '${RouteName.dashboardSave}/${RouteName.individualTargetSaving}');
              }
            },
            buttonTitle: 'Start Saving',
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
