import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class EmployeeSearchBar extends ConsumerWidget {
  const EmployeeSearchBar({
    super.key,
    this.hintText = 'Find Employee',
  });

  final String? hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexSearchField(
      hint: hintText ?? '',
      controller: ref.watch(employeeNotifier).searchEmployeeController,
      onChanged: (value) =>
          ref.watch(employeeNotifier.notifier).filterEmployee(value),
      hintStyle: AppTextStyles.body2Regular.copyWith(
        color: AppColors.rexTint500,
        fontSize: 13.asp,
      ),
      enabledBorderColor: AppColors.rexWhite,
      borderRadius: 15.ar,
    );
  }
}
