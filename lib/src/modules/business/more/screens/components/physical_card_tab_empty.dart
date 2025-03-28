import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:go_router/go_router.dart';

class PhysicalCardTabEmpty extends StatelessWidget {
  const PhysicalCardTabEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No Physical Card yet',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.rexPurpleDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text('Click the button below to request a physical card'),
        SizedBox(
          width: 160,
          child: RexElevatedButton(
            onPressed: () {
              context.push(
                "${RouteName.dashboardMoreBusiness}/${RouteName.cardsDelivery}",
              );
            },
            buttonTitle: 'Request Card',
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
