import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/user_management/models/role_name.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_user_management_action.dart';

class UserManagementCreated extends StatelessWidget {
  const UserManagementCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: ListView.builder(
        itemCount: roleNamesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                tileColor: AppColors.rexWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showModalUserManagementAction(
                      context: context,
                      onPressed: () {
                        context.pop();
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
                title: Text(roleNamesList[index].title),
                subtitle: Text(roleNamesList[index].description),
              ),
            ),
          );
        },
      ),
    );
  }
}
