import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/transaction_filter_date.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class FilterModalDatePicker extends ConsumerWidget {
  const FilterModalDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(transactionFilterDateProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text(StringAssets.filterDate1),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 730)),
                    lastDate: DateTime.now().add(const Duration(days: 730)),
                  ).then((value) {
                    ref
                        .read(transactionFilterDateProvider.notifier)
                        .onStartDateChange(value);
                  });
                },
                child: RexTextField(
                  obscureText: false,
                  hintText: provider.startDate == null
                      ? ''
                      : DateFormat.yMMMd().format(provider.startDate!),
                  controller: provider.startController,
                  showOuterTile: true,
                  enabled: false,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(StringAssets.filterDate2),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 730)),
                    lastDate: DateTime.now().add(const Duration(days: 730)),
                  ).then((value) {
                    ref
                        .read(transactionFilterDateProvider.notifier)
                        .onEndDateChange(value);
                  });
                },
                child: RexTextField(
                  obscureText: false,
                  hintText: provider.endDate == null
                      ? ''
                      : DateFormat.yMMMd().format(provider.endDate!),
                  controller: provider.endController,
                  showOuterTile: true,
                  enabled: false,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
