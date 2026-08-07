import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/eod_pagination_notifier.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/reprint_eod/ui_widgets/eod_select_start_date.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

void showEodFilterBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const EodFilterBottomSheet(),
  );
}

class EodFilterBottomSheet extends ConsumerStatefulWidget {
  const EodFilterBottomSheet({super.key});

  @override
  ConsumerState<EodFilterBottomSheet> createState() =>
      _EodFilterBottomSheetState();
}

class _EodFilterBottomSheetState extends ConsumerState<EodFilterBottomSheet> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final state = ref.read(reprintProvider);
    _startDate = _tryParseApiDate(state.startDate);
    _endDate = _tryParseApiDate(state.endDate);
  }

  DateTime? _tryParseApiDate(String value) {
    if (value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart
        ? (_startDate ?? now)
        : (_endDate ?? _startDate ?? now);
    final firstDate = isStart
        ? DateTime(now.year - 3)
        : (_startDate ?? DateTime(now.year - 3));

    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(now) ? now : initial,
      firstDate: firstDate,
      lastDate: now,
      helpText: isStart ? 'Select Start Date' : 'Select End Date',
    );

    if (picked == null) return;

    setState(() {
      if (isStart) {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = null;
        }
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _onApply() async {
    final notifier = ref.read(reprintProvider.notifier);
    if (_startDate != null) {
      notifier.setStartDate(_startDate!);
    }
    if (_endDate != null) {
      notifier.setEndDate(_endDate!);
    } else if (_startDate != null) {
      notifier.setEndDate(_startDate!);
    }
    context.pop();
    await ref.read(eodPaginationProvider.notifier).applyDateFilter();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.aw,
        right: 20.aw,
        top: 24.ah,
        bottom: bottomInset + 24.ah,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Print EOD',
                  style: TextStyle(
                    fontSize: 20.asp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexPurpleDark3,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.close,
                  size: 22.ar,
                  color: AppColors.rexTint500,
                ),
              ),
            ],
          ),
          SizedBox(height: 28.ah),
          _EodFilterDateField(
            label: 'Start Date',
            value: _startDate,
            trailing: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.rexPurpleDark3,
              size: 24.ar,
            ),
            onTap: () => _pickDate(isStart: true),
          ),
          SizedBox(height: 20.ah),
          _EodFilterDateField(
            label: 'End Date',
            value: _endDate,
            trailing: Icon(
              Icons.calendar_today_outlined,
              color: AppColors.rexPurpleDark3,
              size: 20.ar,
            ),
            onTap: () => _pickDate(isStart: false),
          ),
          SizedBox(height: 32.ah),
          RexElevatedButton(
            onPressed: _onApply,
            buttonTitle: 'Apply',
            backgroundColor: AppColors.rexPurpleDark3,
            verticalPadding: 0,
          ),
        ],
      ),
    );
  }
}

class _EodFilterDateField extends StatelessWidget {
  const _EodFilterDateField({
    required this.label,
    required this.value,
    required this.trailing,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.asp,
            fontWeight: FontWeight.w500,
            color: AppColors.rexPurpleDark3,
          ),
        ),
        SizedBox(height: 8.ah),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 16.ah),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F8FF),
              borderRadius: BorderRadius.circular(12.ar),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value == null ? 'dd/mm/yy' : formatEODdate(value!),
                    style: TextStyle(
                      fontSize: 15.asp,
                      fontWeight: FontWeight.w400,
                      color: value == null
                          ? AppColors.rexTint500
                          : AppColors.rexPurpleDark3,
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
