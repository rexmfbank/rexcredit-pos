import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/components/user_management_created.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/components/user_management_empty.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class BusinessUserManagementScreen extends ConsumerWidget {
  const BusinessUserManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'User management',
        subtitle: 'Manage your users and assign roles',
      ),
      //body: const UserManagementEmpty(),
      body: const UserManagementCreated(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            "${Routes.dashboardMoreBusiness}/${Routes.businessCreateRole}",
          );
        },
        backgroundColor: AppColors.rexPurpleLight,
        child: const Icon(Icons.add),
      ),
    );
  }
}
