import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/purchase/provider/pos_card_method_channel.dart';
import 'package:rex_app/src/modules/individual/purchase/ui/components/int_ext.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/transaction_summary_card.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/screens/receipt_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/navigation.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TransactionDetailScreenBody extends ConsumerWidget {
  const TransactionDetailScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusinessAccount = ref.watch(userIsBusinessProvider);
    final data = ref.watch(inMemoryRecentTransaction);

    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        TransactionsSummaryCard(transData: data),
        SizedBox(height: 8.ah),
        ListTile(
          leading: const Icon(
            Icons.report_outlined,
            size: 28,
            color: AppColors.rexPurpleDark,
          ),
          title: const Text(
            StringAssets.reportTransactionText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(
            Icons.navigate_next_outlined,
            color: AppColors.rexPurpleDark,
          ),
          onTap: () {
            if (isBusinessAccount) {
              context.push(
                  "${RouteName.dashboardBusiness}/${RouteName.businessTransactionDispute}");
            } else {
              context.push(
                  "${RouteName.dashboardIndividual}/${RouteName.individualTransactionDispute}");
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.aw, vertical: 8.ah),
          child: RexFlatButton(
            onPressed: () => context.pushSuper(
              TransferReceiptScreen(receiptData: data),
            ),
            buttonTitle: StringAssets.viewReceipt,
            backgroundColor: null,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.aw, vertical: 8.ah),
          child: RexFlatButton(
            onPressed: () async {
              sendToPrintTransferDetail(data);
            },
            buttonTitle: "Print receipt",
            backgroundColor: AppColors.rexTint400,
          ),
        ),
        15.spaceHeight(),
      ],
    );
  }
}
