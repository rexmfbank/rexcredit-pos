import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_filter_notifier.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_trans_date_notifier.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/filter_modal_header.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showPosFilterTransaction({
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
      return PosFilterBottomSheetContent(
        onClickApply: onClickApply,
        onResetDateFilter: onResetDateFilter,
      );
    },
  );
}

class PosFilterBottomSheetContent extends ConsumerStatefulWidget {
  const PosFilterBottomSheetContent({
    super.key,
    required this.onClickApply,
    this.onResetDateFilter,
  });

  final void Function()? onClickApply;
  final void Function()? onResetDateFilter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PosFilterBottomSheetContentState();
}

class _PosFilterBottomSheetContentState
    extends ConsumerState<PosFilterBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    final filterDate = ref.watch(posTransDateProvider);
    final selectedStatus = ref.watch(posFilterTransStatusProvider);
    final selectedTranCode = ref.watch(posFilterTransCodeProvider);

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
            SizedBox(height: 14.ah),
            const Divider(thickness: 1),
            //
            const FilterTitle(text: 'Type'),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.aw,
                runSpacing: 4.ah,
                children:
                    PosFilterTransCode.values.map((status) {
                      final isSelected = selectedTranCode == status;
                      return ChoiceChip(
                        label: Text(
                          status.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          ref.read(posFilterTransCodeProvider.notifier).state =
                              status;
                        },
                        selectedColor: AppColors.rexBlue,
                      );
                    }).toList(),
              ),
            ),
            Divider(thickness: 1.ah),
            //
            const FilterTitle(text: 'Payment Status'),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.aw,
                runSpacing: 4.ah,
                children:
                    PosFilterTransStatus.values.map((status) {
                      final isSelected = selectedStatus == status;
                      return ChoiceChip(
                        label: Text(
                          status.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          ref
                              .read(posFilterTransStatusProvider.notifier)
                              .state = status;
                        },
                        selectedColor: AppColors.rexBlue,
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 12.ah),
            Divider(thickness: 1.ah),

            // Date Filter
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

            Row(
              children: [
                const Text(StringAssets.filterDate1),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 730),
                        ),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        ref
                            .read(posTransDateProvider.notifier)
                            .onStartDateChange(value);
                      });
                    },
                    child: RexTextField(
                      obscureText: false,
                      hintText: filterDate.startString,
                      controller: filterDate.startController,
                      showOuterTile: true,
                      hintStyle: const TextStyle(color: Colors.black),
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
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 730),
                        ),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        ref
                            .read(posTransDateProvider.notifier)
                            .onEndDateChange(value);
                      });
                    },
                    child: RexTextField(
                      hintText: filterDate.endString,
                      controller: filterDate.endController,
                      showOuterTile: true,
                      hintStyle: const TextStyle(color: Colors.black),
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
  const FilterTitle({super.key, required this.text, this.onTap});

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
