import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

mixin AppActionsMixin {
  bool featureEnabledCheck({
    required BuildContext context,
    required AppMenuDto feature,
  }) {
    if (feature.status) {
      return true;
    }
    context.showToast(message: Strings.featureDisabled);
    return false;
  }

  void showDatePickerModal({
    required BuildContext context,
    required DateTime selectedDate,
    required Function(DateTime) onSelected,
  }) async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (datePicked != null && datePicked != selectedDate) {
      onSelected.call(datePicked);
    }
  }
}
