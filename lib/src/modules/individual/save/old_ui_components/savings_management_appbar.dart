import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_top_up_bottom_sheet.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_withdrawal_bottom_sheet.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SavingsManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SavingsManagementAppBar(
      {super.key,
      required this.hasBackButton,
      required this.title,
      required this.maturity,
      required this.maturityDate,
      required this.planId,
      this.hasActionButton = false,
      required this.balance,
      this.onActionButtonPressed});

  final bool hasBackButton;
  final String title;
  final bool hasActionButton;
  final String maturity;
  final String maturityDate;
  final int planId;
  final String balance;
  final VoidCallback? onActionButtonPressed;

  @override
  Size get preferredSize => const Size.fromHeight(336.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(225, 239, 255, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  hasBackButton
                      ? const BackButton(color: AppColors.rexPurpleDark)
                      : Container(),
                  _RexAppBarActions(),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(AssetPath.savingsSampleImage),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 4.0, bottom: 2.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.rexPurpleDark,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/png/unlock_icon.png',
                          width: 20.0, height: 20.0),
                      const SizedBox(width: 8.0),
                      Text(
                        maturity,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.rexPurpleDark),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 4.0),
                          child: RexFlatButton(
                            onPressed: () {
                              showSavingsWithdrawModalSheet(
                                  context: context,
                                  planId: planId,
                                  balance: balance,
                                  maturityDate: maturityDate);
                            },
                            textColor: AppColors.rexPurpleDark,
                            buttonTitle:
                                StringAssets.withdrawBalanceOnButtonText,
                            backgroundColor:
                                const Color.fromARGB(230, 185, 210, 246),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 4.0, right: 16.0),
                          child: RexFlatButton(
                            onPressed: () {
                              showSavingsTopUpModalSheet(
                                  context: context, planId: planId);
                            },
                            buttonTitle: StringAssets.topupBalanceOnButtonText,
                            backgroundColor: AppColors.rexPurpleDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
class _RexAppBarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          color: AppColors.rexPurpleDark,
          onPressed: () {},
          icon: Image.asset(AssetPath.notificationIconImage),
        ),
        IconButton(
          color: AppColors.rexPurpleDark,
          onPressed: () {},
          icon: Image.asset(AssetPath.userProfileIconImage),
        ),
      ],
    );
  }
}
