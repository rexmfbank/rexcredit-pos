import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_cable/provider/cable_tv_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_cable/widgets/select_bouquet_plan.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showSelectBouquetModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) => const SelectBouquetPlan(),
  );
}
