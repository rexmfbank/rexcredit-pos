import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_option_with_icon_item_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

void showPayrollActionsModal(
  BuildContext context,
) {
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
      return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.rexPurpleDark,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'See what you can do below',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
              ),
              InvestmentTypeCard(
                iconPath: 'assets/png/show_icon.png',
                investmentTitle: 'View Payee due',
                investmentSubTitle: 'See payee due of all your employees',
                onTap: () {},
              ),
              InvestmentTypeCard(
                iconPath: 'assets/png/download_icon.png',
                investmentTitle: 'Download all payee due',
                investmentSubTitle: 'Save payee due of all your employees',
                onTap: () {},
              ),
              const SizedBox(
                height: 16,
              ),
              RexFlatButton(
                  onPressed: () {
                    context.pop();
                  },
                  buttonTitle: 'Close',
                  textColor: AppColors.rexPurpleLight,
                  backgroundColor: AppColors.rexWhite)
            ],
          ),
        );
      });
    },
  );
}
