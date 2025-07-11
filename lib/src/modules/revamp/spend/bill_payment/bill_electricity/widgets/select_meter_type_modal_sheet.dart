import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_electricity/provider/electricity_provider.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_electricity/widgets/meter_type_list.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_bottom_modal_sheet.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showSelectMeterTypeModal(BuildContext context) {
  showPlatformBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    child: const MeterTypeList(),
  );
}
