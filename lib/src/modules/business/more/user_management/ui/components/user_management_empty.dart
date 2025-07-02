import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class UserManagementEmpty extends StatelessWidget {
  const UserManagementEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          child: Container(),
        ),
        const Text(
          'Create a role',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.rexPurpleDark,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Click the button below to create and management permissions',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: 200,
          child: RexElevatedButton(
            onPressed: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.businessCreateRole}",
              );
            },
            buttonTitle: 'Create Role',
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
