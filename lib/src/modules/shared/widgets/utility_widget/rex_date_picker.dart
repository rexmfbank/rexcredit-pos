import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RexDatePicker extends ConsumerWidget {
  const RexDatePicker({
    super.key,
    this.givenDate,
    this.initialYear,
    required this.earliestYear,
    required this.latestYear,
    required this.onTap,
  });

  final DateTime? givenDate;
  final int? initialYear;
  final int earliestYear;
  final int latestYear;
  final void onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(earliestYear),
          lastDate: DateTime(latestYear),
        ).then((value) {
          onTap;
        });
      },
      child: RexTextField(
        outerTitle: StringAssets.dobText,
        obscureText: false,
        hintText: givenDate == null
            ? StringAssets.selectDate
            : DateFormat.yMMMd().format(givenDate!),
        controller: null,
        showOuterTile: true,
        enabled: false,
      ),
    );
  }
}