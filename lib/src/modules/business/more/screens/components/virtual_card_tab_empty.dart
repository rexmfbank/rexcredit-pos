import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class VirtualCardTabEmpty extends StatelessWidget {
  const VirtualCardTabEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No Virtual Card yet',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.rexPurpleDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text('Click the button below to request a virtual card'),
        SizedBox(
          width: 160,
          child: RexElevatedButton(
            onPressed: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.virtualCardApply}",
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
