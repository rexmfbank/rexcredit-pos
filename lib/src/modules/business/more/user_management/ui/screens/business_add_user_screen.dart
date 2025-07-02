import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/components/business_add_user_name_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class BusinessAddUserScreen extends StatefulHookConsumerWidget {
  const BusinessAddUserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessAddUserScreenState();
}

class _BusinessAddUserScreenState extends ConsumerState<BusinessAddUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Add user',
        subtitle: 'Add a new user to a role',
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
          const BusinessAddUserNameDropdown(),
          Expanded(child: Container()),
          RexElevatedButton(
            onPressed: () {
              showModalAction(
                context: context,
                dialogTitle: 'User Added',
                dialogSubtitle:
                    'Adekunle Michael has been added to account manager role',
                onPressed: () {
                  context.go(
                      "${Routes.dashboardMoreBusiness}/${Routes.businessUserManagement}");
                },
              );
            },
            buttonTitle: 'Add user',
            backgroundColor: null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
