import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_user_management_delete_role.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

void showModalUserManagementAction({
  required BuildContext context,
  required void Function()? onPressed,
}) {
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
      return SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Actions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.rexPurpleLight,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('See what you can do below'),
              ),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('Add user'),
                subtitle: const Text('Add new user to role'),
                trailing: const Icon(Icons.navigate_next),
                leading: Image.asset(AssetPath.iconAddUser),
                onTap: () {
                  context.pop();
                  context.push(
                    "${Routes.dashboardMoreBusiness}/${Routes.businessAddUser}",
                  );
                },
              ),
              ListTile(
                title: const Text('View users'),
                subtitle: const Text('Manage your role users'),
                trailing: const Icon(Icons.navigate_next),
                leading: Image.asset(AssetPath.iconView),
                onTap: () {
                  context.pop();
                  context.push(
                    "${Routes.dashboardMoreBusiness}/${Routes.businessViewUsers}",
                  );
                },
              ),
              ListTile(
                title: const Text('Delete role'),
                subtitle: const Text('Remove the role'),
                trailing: const Icon(Icons.navigate_next),
                leading: Image.asset(AssetPath.iconDelete),
                onTap: () {
                  context.pop();
                  showModalUserManagementDeleteRole(
                    context: context,
                    yesButton: () {
                      //context.pop();
                      // showModalActionSuccessful(
                      //   context: context,
                      //   dialogTitle: 'Role Deleted!',
                      //   dialogSubtitle: 'Role has been successfully deleted',
                      //   onPressed: () {
                      //     context.pop();
                      //   },
                      // );
                    },
                    cancelButton: () {
                      // context.pop();
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              RexElevatedButton(
                onPressed: onPressed,
                buttonTitle: 'Close',
                backgroundColor: AppColors.grey2,
                foregroundColor: AppColors.rexPurpleLight,
              ),
            ],
          ),
        ),
      );
    },
  );
}
