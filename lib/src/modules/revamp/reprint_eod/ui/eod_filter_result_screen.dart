import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/ui_widgets/pos_trans_history_item.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/model/eod_pagination_state.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/provider/eod_pagination_notifier.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/revamp/widget/linear_loading_indicator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EODFilterResultScreen extends ConsumerStatefulWidget {
  const EODFilterResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EODFilterResultScreenState();
}

class _EODFilterResultScreenState extends ConsumerState<EODFilterResultScreen> {
  //
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState = ref.read(eodPaginationProvider);
      if (currentState.dataList.isNotEmpty) {
        ref.read(eodPaginationProvider.notifier).refresh();
      } else {
        // No data or error state, fetch fresh data
        ref.read(eodPaginationProvider.notifier).fetch();
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        ref.read(eodPaginationProvider.notifier).fetch();
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
    final eodPaginationState = ref.watch(eodPaginationProvider);
    final eodPaginationNotifier = ref.read(eodPaginationProvider.notifier);
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'End-Of-Day Transactions'),
      body: Column(
        children: [
          SizedBox(height: 8.ah),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              backgroundColor: AppColors.rexTint400,
              onPressed: () {
                eodPaginationNotifier.printEODTest(context);
              },
              buttonTitle: "Print EOD Receipt",
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              margin: EdgeInsets.all(16.ar),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.ar),
              ),
              child: _buildListContent(
                eodPaginationState,
                eodPaginationNotifier,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent(
    EodPaginationState eodPaginationState,
    EodPaginationNotifier eodPaginationNotifier,
  ) {
    if (eodPaginationState.dataList.isEmpty && !eodPaginationState.isLoading) {
      return const Center(child: Text('No transactions found'));
    }
    // Show initial loading state (when no data exists yet)
    if (eodPaginationState.dataList.isEmpty &&
        eodPaginationState.isLoading &&
        !eodPaginationState.isRefresh) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: eodPaginationState.dataList.length + 1,
      itemBuilder: (context, index) {
        if (index < eodPaginationState.dataList.length) {
          return PosTransHistoryItem(
            trans: eodPaginationState.dataList[index],
            canTap: false,
          );
        } else {
          return _buildBottomIndicator(
            eodPaginationState,
            eodPaginationNotifier,
          );
        }
      },
    );
  }

  Widget _buildBottomIndicator(
    EodPaginationState posPaginationState,
    EodPaginationNotifier posPaginationNotifier,
  ) {
    if (posPaginationState.dataList.isEmpty) {
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
