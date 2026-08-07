import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/eod_pagination_notifier.dart';
import 'package:rex_app/src/modules/reprint_eod/ui_widgets/eod_filter_bottom_sheet.dart';
import 'package:rex_app/src/modules/reprint_eod/ui_widgets/eod_filter_result.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

class EODSelectScreen extends ConsumerStatefulWidget {
  const EODSelectScreen({super.key, required this.isOutside});

  final bool isOutside;

  @override
  ConsumerState<EODSelectScreen> createState() => _EODSelectScreenState();
}

class _EODSelectScreenState extends ConsumerState<EODSelectScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 700), () {
      ref.read(eodPaginationProvider.notifier).applySearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.ah),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 56.ah,
                  decoration: BoxDecoration(
                    color: AppColors.rexWhite,
                    borderRadius: BorderRadius.circular(32.ar),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 22.aw),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    style: TextStyle(
                      fontSize: 16.asp,
                      color: AppColors.rexPurpleDark3,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 16.asp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.rexTint500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.aw),
              GestureDetector(
                onTap: () => showEodFilterBottomSheet(context: context),
                child: Container(
                  height: 56.ah,
                  width: 56.aw,
                  decoration: BoxDecoration(
                    color: AppColors.rexWhite,
                    borderRadius: BorderRadius.circular(16.ar),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    AssetPath.filterIcon,
                    height: 24.ah,
                    width: 24.aw,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: EODFilterResult(outside: widget.isOutside),
        ),
      ],
    );
  }
}
