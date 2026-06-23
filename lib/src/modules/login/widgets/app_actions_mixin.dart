import 'package:flutter/material.dart';

mixin AppActionsMixin {
  // bool featureEnabledCheck({
  //   required BuildContext context,
  //   required AppMenuDto feature,
  // }) {
  //   if (feature.status) {
  //     return true;
  //   }
  //   context.showSnack(message: Strings.featureDisabled);
  //   return false;
  // }

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