import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessLoanRepayment extends ConsumerWidget {
  const BusinessLoanRepayment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Set up repayment method',
        subtitle: 'Choose your preferred payment type',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.rexWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Saved Cards'),
                  const SizedBox(height: 8.0),
                  CheckboxListTile(
                    value: false,
                    onChanged: (value) {},
                    title: const Text('**** **** **** 5967'),
                    subtitle: const Text('Expires 09/25'),
                    secondary: Image.asset(AssetPath.logoMastercard),
                  ),
                  CheckboxListTile(
                    value: false,
                    onChanged: (value) {},
                    title: const Text('**** **** **** 5967'),
                    subtitle: const Text('Expires 09/25'),
                    secondary: Image.asset(AssetPath.logoMastercard),
                  ),
                  RexElevatedButton(
                    onPressed: () {
                      context.push(
                        "${RouteName.dashboardBusiness}/${RouteName.businessAddCard}",
                      );
                    },
                    buttonTitle: 'Add new card',
                    backgroundColor: AppColors.rexLightBlue2,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: RexElevatedButton(
                onPressed: () {
                  showModalAction(
                    context: context,
                    dialogTitle: 'Repayment Set!',
                    dialogSubtitle: StringAssets.repaymentSetSubtitle,
                    onPressed: () {
                      context.pop();
                      context.go(RouteName.dashboardBusiness);
                    },
                  );
                },
                buttonTitle: 'Submit',
                backgroundColor: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
