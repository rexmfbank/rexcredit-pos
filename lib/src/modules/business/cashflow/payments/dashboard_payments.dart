import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class DashboardPaymentsScreen extends HookConsumerWidget {
  const DashboardPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Payments Link',
        subtitle: 'Manage your products with Rex',
        hasActionButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              child: Lottie.asset('assets/lottiefiles/payment_link.json'),
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Start selling fast',
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
                  'Sell your product or service by sharing a link to a payment page with your customers',
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
                  context.push(
                      '${RouteName.dashboardBusiness}/${RouteName.paymentLink}');
                },
                buttonTitle: 'Create Link',
                backgroundColor: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
