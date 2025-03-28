import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/user_management/models/role_permission.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class BusinessCreateRoleScreen extends StatefulHookConsumerWidget {
  const BusinessCreateRoleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessCreateRoleScreenState();
}

class _BusinessCreateRoleScreenState
    extends ConsumerState<BusinessCreateRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Create a role',
        subtitle: 'Create a user role and permissions',
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, left: 14.0),
              child: Text('Role name'),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Account Managaer'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
              child: ListView.builder(
                itemCount: rolePermissionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: CheckboxListTile(
                      tileColor: AppColors.rexWhite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                      value: false,
                      onChanged: (value) {},
                      title: Text(rolePermissionList[index].title),
                      subtitle: Text(rolePermissionList[index].description),
                    ),
                  );
                },
              ),
            ),
          ),
          RexElevatedButton(
            onPressed: () {
              showModalAction(
                context: context,
                dialogTitle: 'Role created',
                dialogSubtitle: 'Account manager role has been created',
                onPressed: () {
                  context.go(
                    "${RouteName.dashboardMoreBusiness}/${RouteName.businessUserManagement}",
                  );
                },
              );
            },
            buttonTitle: 'Create role',
            backgroundColor: null,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
