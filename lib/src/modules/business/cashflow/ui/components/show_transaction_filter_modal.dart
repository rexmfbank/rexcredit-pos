import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/custom_chip_group.dart';
import 'package:rex_app/src/modules/business/more/profile/business_profile_setup_withdrawal_limit.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

/// NOTE: I don't think you should call this widget
/// becuase it is part of the old UI for savings and I
/// do not think it is functional.
/// use [showFilterTransaction] which is the modal bottom sheet
/// that can be seen in the [AllTransactionsScreenBody]
void showTransactionFilterModal(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Image.asset('assets/png/close_circle_icon.png'))
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Filter all your transactions on Rex',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'Quick Filter',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                ChipGroupExample(),
                SizedBox(height: 14),
                Text(
                  'Bill Payments',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                ChipGroupExample(),
                SizedBox(height: 10),
                Text(
                  'Amount Range Filter',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                CustomSlider(
                  minValue: 0.0,
                  maxValue: 1000.0,
                  value: 10.0,
                  sliderColor: AppColors.cardBrown,
                  onChanged: (value) {},
                  amountController: null,
                ),
                const SizedBox(
                  height: 12,
                ),
                RexFlatButton(
                    onPressed: () {
                      context.pop();
                    },
                    buttonTitle: 'Apply Filter',
                    backgroundColor: null),
              ],
            ),
          ),
        );
      });
    },
  );
}
