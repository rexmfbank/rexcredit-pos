import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/transactions/refactor_pos/pos_pagination_notifier.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/transactions/refactor_pos/pos_pagination_state.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/ui_widgets/pos_trans_history_item.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/revamp/widget/linear_loading_indicator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class QuickTransactionsScreen extends ConsumerStatefulWidget {
  const QuickTransactionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransactionsScreenState();
}

class _QuickTransactionsScreenState
    extends ConsumerState<QuickTransactionsScreen> {
  //
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState = ref.read(posPaginationProvider);
      if (currentState.dataList.isNotEmpty) {
        ref.read(posPaginationProvider.notifier).refresh();
      } else {
        // No data or error state, fetch fresh data
        ref.read(posPaginationProvider.notifier).fetch();
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        ref.read(posPaginationProvider.notifier).fetch();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posPaginationState = ref.watch(posPaginationProvider);
    final posPaginationNotifier = ref.read(posPaginationProvider.notifier);
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'Transaction History'),
      body: _buildListContent(posPaginationState, posPaginationNotifier),
    );
  }

  Widget _buildListContent(
    PosPaginationState posPaginationState,
    PosPaginationNotifier posPaginationNotifier,
  ) {
    if (posPaginationState.dataList.isEmpty && !posPaginationState.isLoading) {
      return const Center(child: Text('No transactions found'));
    }

    // Show initial loading state (when no data exists yet)
    if (posPaginationState.dataList.isEmpty &&
        posPaginationState.isLoading &&
        !posPaginationState.isRefresh) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: posPaginationNotifier.refresh,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: posPaginationState.dataList.length + 1,
        itemBuilder: (context, index) {
          if (index < posPaginationState.dataList.length) {
            return PosTransHistoryItem(
              trans: posPaginationState.dataList[index],
              canTap: true,
            );
          } else {
            return _buildBottomIndicator(
              posPaginationState,
              posPaginationNotifier,
            );
          }
        },
      ),
    );
  }

  Widget _buildBottomIndicator(
    PosPaginationState posPaginationState,
    PosPaginationNotifier posPaginationNotifier,
  ) {
    if (posPaginationState.filteredList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.ah),
      child: Center(
        child:
            posPaginationNotifier.shouldShowLoading
                ? const CircularLoader(height: 25, width: 25)
                : posPaginationNotifier.shouldShowEndOfList
                ? Text(StringAssets.endOfList, style: AppTextStyles.h2)
                : const SizedBox.shrink(),
      ),
    );
  }
}
