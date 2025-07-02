import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/transaction_filter_date.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/all_filter.dart';
import 'package:rex_app/src/modules/shared/widgets/filter_modal_header.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showFilterTransaction({
  required BuildContext context,
  required void Function()? onClickApply,
  required void Function()? onResetDateFilter,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return FilterBottomSheetContent(
        onClickApply: onClickApply,
        onResetDateFilter: onResetDateFilter,
      );
    },
  );
}

class FilterBottomSheetContent extends ConsumerStatefulWidget {
  const FilterBottomSheetContent({
    super.key,
    required this.onClickApply,
    this.onResetDateFilter,
  });

  final void Function()? onClickApply;
  final void Function()? onResetDateFilter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState
    extends ConsumerState<FilterBottomSheetContent> {
  int? _chipValue;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transactionFilterDateProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FilterModalHeader(
              title: StringAssets.filterModalTitle,
              subtitle: StringAssets.filterModalSubtitle,
            ),
            const SizedBox(height: 18),
            const Divider(thickness: 2),
            const FilterTitle(text: StringAssets.filterType1),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.aw,
                runSpacing: 4.ah,
                children: List<Widget>.generate(
                  FilterTransactionType.values.length,
                  (int index) => ChoiceChip(
                    label: Text(FilterTransactionType.values[index].name),
                    selected: _chipValue == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _chipValue = index;
                      });
                      ref.read(selectedFilter.notifier).state = _chipValue!;
                    },
                    selectedColor: AppColors.rexBlue,
                  ),
                ).toList(),
              ),
            ),
            SizedBox(height: 12.ah),
            Divider(thickness: 2.ah),
            //const FilterTitle(text: StringAssets.filterType2),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.ah),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FilterTitle(text: StringAssets.filterType2),
                  FilterTitle(
                    text: StringAssets.filterDate3,
                    onTap: widget.onResetDateFilter,
                  ),
                ],
              ),
            ),
            //const FilterModalDatePicker(),
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
            Divider(thickness: 2.ah),
            RexFlatButton(
              onPressed: widget.onClickApply,
              buttonTitle: StringAssets.filterTextOnBtn,
              backgroundColor: null,
            ),
          ],
        ),
      ),
    );
  }
}

class FilterTitle extends StatelessWidget {
  const FilterTitle({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: onTap,
          child: Text(text, style: AppTextStyles.titleSize14Dark),
        ),
      );
}
