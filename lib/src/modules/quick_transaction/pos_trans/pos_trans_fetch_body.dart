import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/models/extension_on_payload.dart';
import 'package:rex_app/src/modules/api/models/transaction_query_payload.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/int_ext.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/container_style_button.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

class PosTransactionFetchBody extends ConsumerStatefulWidget {
  const PosTransactionFetchBody({
    super.key,
    required this.transRef,
    required this.outside,
  });

  final String transRef;
  final bool outside;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PosTransactionFetchBodyState();
}

class _PosTransactionFetchBodyState
    extends ConsumerState<PosTransactionFetchBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fetchStatusOutsideProvider(widget.transRef));
    return state.when(
      data: (data) {
        return FetchPosQuerySummary(query: data, outside: widget.outside);
      },
      error: (_, _) {
        return Center(
          child: Column(
            children: [
              Text('Sorry, unable to get transaction status'),
              ContainerStyleButton(
                title: 'Back Home',
                bgColor: Color(0xffE8EEFF),
                textColor: Color(0xff002766),
                onTap: () => context.go(Routes.homeScreen),
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
      loading: () {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(radius: 20),
              SizedBox(height: 8),
              Text('Fetching Status'),
            ],
          ),
        );
      },
    );
  }
}

class FetchPosQuerySummary extends ConsumerWidget {
  const FetchPosQuerySummary({
    super.key,
    required this.query,
    required this.outside,
  });

  final TransactionQueryResponse query;
  final bool outside;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(posGlobalProvider);
    return Padding(
      padding: EdgeInsets.all(12),
      child: ListView(
        children: [
          SizedBox(height: 15.ah),
          query.data.status?.toLowerCase() == 'successful'
              ? Icon(Icons.check_circle, color: AppColors.rexGreen, size: 60)
              : Icon(Icons.close, color: AppColors.red, size: 60),
          20.spaceHeight(),
          Text(
            query.data.status?.toLowerCase() == 'successful'
                ? "Transaction Approved!"
                : "Transaction Declined!",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          15.spaceHeight(),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexLightBlue4,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaction Type"),
                    Flexible(
                      child: Text(
                        textAlign: TextAlign.right,
                        query.data.narration == 'card-purchase'
                            ? 'Card Purchase'
                            : query.data.narration ?? 'N/A',
                        style: AppTextStyles.transactionStatus,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount"),
                    Text(
                      "NGN ${query.data.amount?.toStringAsFixed(2)}",
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
                SizedBox(height: 12.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaction Ref"),
                    Flexible(
                      child: Text(
                        textAlign: TextAlign.right,
                        query.data.tranRefNo ?? 'N/A',
                        style: AppTextStyles.transactionStatus,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaction Status"),
                    Text(
                      query.data.status ?? 'n/a',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: query.data.status.posTransStatusColorNull,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.spaceHeight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                                .printTransDetail(query.data.toPrintObj());
                          }
                          : null,
                ),
              ),
              SizedBox(width: 8.aw),
              Expanded(
                child: ContainerStyleButton(
                  title: 'Back Home',
                  bgColor: Color(0xffE8EEFF),
                  textColor: Color(0xff002766),
                  onTap: () {
                    if (outside) {
                      context.go(Routes.homeScreen);
                    } else {
                      context.go(Routes.loginHome);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
