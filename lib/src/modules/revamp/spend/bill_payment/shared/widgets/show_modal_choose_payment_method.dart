import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_bottom_modal_sheet.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

import '../../../../../../utils/currency.dart';
import '../providers/bill_payment_provider.dart';

void showModalChoosePaymentMethod({
  required BuildContext context,
  required VoidCallback onNextTapped,
}) {
  showPlatformBottomSheet(
    context: context,
    child: Padding(
      padding: EdgeInsets.only(left: 12.aw, right: 12.aw, top: 30.ah),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringAssets.choosePaymentMethod,
            style: TextStyle(
              fontSize: 18.asp,
              fontWeight: FontWeight.w700,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 8.ah),
          Text(
            StringAssets.selectPaymentMethodForTransaction,
            style: TextStyle(
              fontSize: 12.asp,
              fontWeight: FontWeight.w500,
              color: AppColors.rexPurpleLight,
            ),
          ),
          SizedBox(height: 15.ah),
          const PayFromAccountBuilder(),
          // SizedBox(height: 15.ah),
          // const PayFromCardBuilder(),
          SizedBox(height: 20.ah),
          RexElevatedButton(
            onPressed: () {
              context.pop();
              onNextTapped();
            },
            buttonTitle: StringAssets.nextTextOnButton,
            backgroundColor: null,
          )
        ],
      ),
    ),
  );
}

class PayFromAccountBuilder extends ConsumerWidget {
  const PayFromAccountBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userAcctBalanceProvider);

    return Container(
      padding: EdgeInsets.all(15.ah),
      decoration: BoxDecoration(
        color: AppColors.cardBlue,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                StringAssets.payFromAccount,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 14.asp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Checkbox(
                value: true,
                onChanged: (value) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                checkColor: AppColors.rexWhite,
                activeColor: AppColors.rexPurpleLight,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          Text(
            StringAssets.accountBalance,
            style: TextStyle(
              color: AppColors.rexTint500,
              fontSize: 12.asp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.ah),
          Text(
            state.value?.data?.availableBalance.formatCurrencyNum() ??
                addNairaCurrencySymbol('0.00'),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.asp,
              color: AppColors.textBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class PayFromCardBuilder extends ConsumerWidget {
  const PayFromCardBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billPaymentProvider);
    final savedCards = state.savedCards ?? [];

    return Container(
      padding: EdgeInsets.all(10.ah),
      decoration: BoxDecoration(
        color: AppColors.cardBlue,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.aw, top: 8.ah),
            child: Text(
              StringAssets.payWithCard,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.asp,
                color: AppColors.textBlack,
              ),
            ),
          ),
          SizedBox(height: 10.ah),
          Builder(builder: (context) {
            if (savedCards.isNotEmpty) {
              return SizedBox(
                height: 100.ah,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return SavedCardItem(cardData: savedCards[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5.ah);
                  },
                  itemCount: savedCards.length,
                ),
              );
            }
            return Center(
              child: Text(
                StringAssets.youHaveNoSavedCards,
                style: TextStyle(
                  fontSize: 12.asp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
            );
          }),
          SizedBox(height: 10.ah),
          RexElevatedButton(
            onPressed: () {
              context.pop();
              context.showSnackBar(message: StringAssets.notYetAvailable);

              ///todo -> navigate user to add card
            },
            buttonTitle: StringAssets.addNewCard,
            backgroundColor: const Color(0xFFABC2F5),
          ),
        ],
      ),
    );
  }
}

class SavedCardItem extends StatelessWidget {
  const SavedCardItem({super.key, required this.cardData});

  final DebitCardData cardData;

  @override
  Widget build(BuildContext context) {
    final brandName = cardData.brand.toUpperCase();
    final isMaster = brandName.contains('MASTER');

    return CheckboxListTile(
      value: false,
      onChanged: (newValue) {},
      title: Text(
        cardData.maskedPan,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12.asp,
          color: AppColors.textBlack,
        ),
      ),
      subtitle: Text(
        'Expires ${cardData.expiryDate}',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 10.asp,
          color: AppColors.rexTint500,
        ),
      ),
      secondary: Image.asset(
        isMaster ? AssetPath.logoMastercard : AssetPath.logoVisa,
        width: 29.aw,
        height: 29.ah,
      ),
      checkColor: AppColors.rexWhite,
      activeColor: AppColors.rexPurpleLight,
      controlAffinity: ListTileControlAffinity.trailing,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
