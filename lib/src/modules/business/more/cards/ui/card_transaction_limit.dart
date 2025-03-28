import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/components/transaction_limit_tile.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CardTransactionLimit extends ConsumerWidget {
  const CardTransactionLimit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(cardNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const CustomAppBar(
        title: StringAssets.cardTransactionLimit,
        subtitle: StringAssets.setTransactionLimitThroughSlider,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.ah),
          TransactionLimitTile(
            title: StringAssets.atmTransactions,
            startingValue: double.parse(
                ref.watch(cardNotifier).cardDetail?.product?.minLimit ?? '0'),
            endingValue: double.parse(
                ref.watch(cardNotifier).cardDetail?.product?.atmLimit ?? '0'),
            currentValue: ref.watch(cardNotifier).atmTransactionLimit,
            onChanged: (value) => ref
                .watch(cardNotifier.notifier)
                .updateAtmTransactionLimit(value),
          ),
          TransactionLimitTile(
            title: StringAssets.posTransactions,
            startingValue: double.parse(
                ref.watch(cardNotifier).cardDetail?.product?.minLimit ?? '0'),
            endingValue: double.parse(
                ref.watch(cardNotifier).cardDetail?.product?.posLimit ?? '0'),
            currentValue: ref.watch(cardNotifier).posTransactionLimit,
            onChanged: (value) => ref
                .watch(cardNotifier.notifier)
                .updatePosTransactionLimit(value),
          ),
          TransactionLimitTile(
            title: StringAssets.onlineTransactions,
            startingValue: double.parse(
                ref.watch(cardNotifier).cardDetail?.product?.minLimit ?? '0'),
            endingValue: double.parse(
                ref.watch(cardNotifier).cardDetail?.product?.webLimit ?? '0'),
            currentValue: ref.watch(cardNotifier).onlineTransactionLimit,
            onChanged: (value) => ref
                .watch(cardNotifier.notifier)
                .updateOnlineTransactionLimit(value),
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RexFlatButton(
            onPressed: () => ref
                .watch(cardNotifier.notifier)
                .setWithdrawalLimit(context: context),
            buttonTitle: StringAssets.saveText,
            backgroundColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 15.ah),
        ],
      ),
    );
  }
}
