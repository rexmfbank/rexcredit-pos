import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/staff_actions.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_option_with_icon_item_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

void showEmployeeActionsModal({
  required BuildContext context,
  required EmployeeInfoDTO employeeInfo,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.ar),
        topRight: Radius.circular(16.ar),
      ),
    ),
    builder: (context) {
      return StaffActions(
        employeeInfo: employeeInfo,
      );
    },
  );
}
