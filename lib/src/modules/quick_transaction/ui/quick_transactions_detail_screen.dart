import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/models/extension_on_payload.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/quick_transaction/ui_widgets/quick_transaction_detail_widgets.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/container_style_button.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

class QuickTransactionsDetailScreen extends ConsumerStatefulWidget {
  const QuickTransactionsDetailScreen({super.key, this.data});

  final PosTransactionsResponseData? data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransactionDetailScreen();
}

class _QuickTransactionDetailScreen
    extends ConsumerState<QuickTransactionsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final detail =
        widget.data == null ? ref.watch(memoryPosTransProvider) : widget.data!;
    final state = ref.watch(posGlobalProvider);
    //
    return AppScaffold(
      appBar: AppbarSubScreen(title: 'Transaction Details', centerTitle: true),
      backgroundColor: AppColors.rexBackground,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          QuickTransactionsDetailSummary(posTransaction: detail),
          SizedBox(height: 16.ah),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ContainerStyleButton(
                  title: 'Fetch Status',
                  bgColor: AppColors.rexWhite,
                  textColor: Color(0xff002766),
                  border: Border.all(color: Color(0xff002766)),
                  onTap: () {
                    context.push(
                      Routes.quickTransactionFetchStatus,
                      extra: detail.tranRefNo ?? '',
                    );
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ContainerStyleButton(
                  title: 'Print Receipt',
                  bgColor: state.canPrint ? Color(0xff002766) : AppColors.grey,
                  textColor: AppColors.rexWhite,
                  onTap:
                      state.canPrint
                          ? () {
                            ref
                                .read(posGlobalProvider.notifier)
                                .printTransDetail(detail.toPrintObj());
                          }
                          : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.ah),
          detail.status == null
              ? SizedBox.shrink()
              : QuickTransactionReportButtonn(posTransaction: detail),
          SizedBox(height: 4.ah),
        ],
      ),
    );
  }
}
