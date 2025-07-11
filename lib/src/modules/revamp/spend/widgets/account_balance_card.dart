import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/components/account_balance_text.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

import '../../../shared/providers/app_preference_provider.dart';

class AccountBalanceCard extends ConsumerStatefulWidget {
  const AccountBalanceCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountBalanceCard();
}

class _AccountBalanceCard extends ConsumerState<AccountBalanceCard> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userAcctBalanceProvider);
    final hideBalance = ref.watch(hideAccountProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringAssets.accountBalance,
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.w),
              state.isLoading
                  ? SizedBox(
                      height: 5.h,
                      width: 5.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.w,
                      ),
                    )
                  : const AccountBalanceText(),


            ],
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  AssetPath.accountBalance,
                  width: 45,
                  height: 45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
