import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/enums/transaction_codes.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../../utils/constants/app_text_styles.dart';
import '../../../../../../utils/constants/asset_path.dart';
import '../../../../../../utils/constants/string_assets.dart';

class SavedPaymentTab extends ConsumerStatefulWidget {
  const SavedPaymentTab(this.tranCode, {super.key, this.beneficiaryName});

  final TransactionCodes tranCode;
  final String? beneficiaryName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedPaymentTab();
}

class _SavedPaymentTab extends ConsumerState<SavedPaymentTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(billPaymentProvider.notifier)
          .fetchBeneficiaries(context, widget.tranCode.jsonString);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Builder(builder: (context) {
        var beneficiaries = (ref.watch(billPaymentProvider).beneficiaries ?? [])
          ..removeWhere((element) =>
              element.beneficiaryAccount.isBlank ||
              element.tranCode != widget.tranCode.jsonString);
        if (beneficiaries.isEmpty) {
          return Align(
            alignment: Alignment.center,
            child: Text(
              StringAssets.noBeneficiariesAvailable,
              style: AppTextStyles.h2.copyWith(
                color: AppColors.rexPurpleLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return SavedPaymentItem(
              beneficiary: beneficiaries[index],
              beneficiaryName: widget.beneficiaryName,
              onTap: () =>
                  ref.watch(billPaymentProvider.notifier).beneficiaryNavigation(
                        tran: widget.tranCode,
                        data: beneficiaries[index],
                      ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10.ah);
          },
          itemCount: beneficiaries.length,
        );
      }),
    );
  }
}

class SavedPaymentItem extends StatelessWidget {
  const SavedPaymentItem({
    super.key,
    required this.beneficiary,
    required this.onTap,
    this.beneficiaryName,
  });

  final BeneficiaryData beneficiary;
  final VoidCallback onTap;
  final String? beneficiaryName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.aw, 12.ah, 16.aw, 8.ah),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.cardBlue,
              child: SvgPicture.asset(AssetPath.savedPayment),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beneficiaryName ?? beneficiary.beneficiaryName ?? 'N/A',
                  style: TextStyle(
                    color: AppColors.rexPurpleDark,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  beneficiary.beneficiaryAccount ?? 'N/A',
                  style: TextStyle(
                    color: AppColors.rexTint500,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
