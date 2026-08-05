import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/models/extension_on_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/quick_transaction/pos_trans/pos_trans_detail_widgets.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/container_style_button.dart';

class PosTransactionDetailBody extends ConsumerStatefulWidget {
  const PosTransactionDetailBody({
    super.key,
    required this.detail,
    required this.outside,
  });

  final PosTransactionsResponseData detail;
  final bool outside;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PosTransactionDetailBodyState();
}

class _PosTransactionDetailBodyState
    extends ConsumerState<PosTransactionDetailBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posGlobalProvider);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(height: 16.ah),
        PosTransactionDetailCard(trans: widget.detail),
        SizedBox(height: 16.ah),
        widget.detail.tranRefNo?.isFeeNull == true
            ? SizedBox.shrink()
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ContainerStyleButton(
                    title: 'Fetch Status',
                    bgColor: AppColors.rexWhite,
                    textColor: Color(0xff002766),
                    border: Border.all(color: Color(0xff002766)),
                    onTap: () {
                      if (widget.outside) {
                        context.push(
                          Routes.quickTransactionFetchStatus,
                          extra: widget.detail.tranRefNo ?? '',
                        );
                      } else {
                        context.push(
                          Routes.loginTransFetchPath,
                          extra: widget.detail.tranRefNo ?? '',
                        );
                      }
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ContainerStyleButton(
                    title: 'Print Receipt',
                    bgColor:
                        state.canPrint ? Color(0xff002766) : AppColors.grey,
                    textColor: AppColors.rexWhite,
                    onTap:
                        state.canPrint
                            ? () {
                              ref
                                  .read(posGlobalProvider.notifier)
                                  .printTransDetail(widget.detail.toPrintObj());
                            }
                            : null,
                  ),
                ),
              ],
            ),
        SizedBox(height: 8.ah),
        widget.detail.status == null
            ? SizedBox.shrink()
            : PosTransactionReportButton(trans: widget.detail),
        SizedBox(height: 4.ah),
      ],
    );
  }
}
