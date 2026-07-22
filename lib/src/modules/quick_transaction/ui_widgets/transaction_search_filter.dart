import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

class TransactionSearchFilter extends ConsumerWidget {
  const TransactionSearchFilter({
    super.key,
    required this.onTap,
    required this.onChangedText,
  });

  final void Function()? onTap;
  final void Function(String)? onChangedText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 8.ah),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AllTransactionsSearch(onChanged: onChangedText),
          ),
          SizedBox(width: 4.aw),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 85.ah,
              width: 50.aw,
              decoration: BoxDecoration(
                color: AppColors.rexWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(AssetPath.iconFilter),
            ),
          ),
        ],
      ),
    );
  }
}

class AllTransactionsSearch extends ConsumerStatefulWidget {
  const AllTransactionsSearch({super.key, required this.onChanged});

  final void Function(String)? onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllTransactionsSearchState();
}

class _AllTransactionsSearchState extends ConsumerState<AllTransactionsSearch> {
  TextEditingController textController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    textController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel the previous timer
    _debounceTimer?.cancel();

    // Create a new timer that will execute the search after 700ms
    _debounceTimer = Timer(const Duration(milliseconds: 700), () {
      widget.onChanged?.call(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              controller: textController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                hintText: 'Search',
                hintStyle: TextStyle(color: AppColors.rexTint500, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
          if (textController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, size: 20),
              onPressed: () {
                textController.clear();
                _debounceTimer?.cancel();
                widget.onChanged?.call('');
              },
            ),
        ],
      ),
    );
  }
}
