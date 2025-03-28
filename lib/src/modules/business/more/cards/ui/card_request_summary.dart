import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/components/summary_row.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CardRequestSummary extends ConsumerWidget {
  const CardRequestSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(cardNotifier).isLoading,
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.requestSummary,
        subtitle: StringAssets.cardProcessingFeePrompt,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 10.ah),
          SummaryRow(
            title: StringAssets.walletNumber,
            info: ref.watch(cardNotifier).walletNumberController.text,
          ),
          SummaryRow(
            title: StringAssets.nameOnCard,
            info: ref.watch(cardNotifier).cardNameController.text,
          ),
          SummaryRow(
            title: StringAssets.cardType,
            info: ref.watch(cardNotifier).selectedCard,
          ),
          SummaryRow(
            title: StringAssets.deliveryOption,
            info: ref.watch(cardNotifier).selectedDelivery,
          ),
          SummaryRow(
            title: StringAssets.address,
            info: ref.watch(cardNotifier).addressController.text,
          ),
          SummaryRow(
            title: StringAssets.city,
            info: ref.watch(cardNotifier).selectedCity,
          ),
          SummaryRow(
            title: StringAssets.state,
            info: ref.watch(cardNotifier).selectedState,
          ),
          const SummaryRow(
            title: StringAssets.deliveryCost,
            info: 'NGN 0.00',
          ),
          SummaryRow(
            title: StringAssets.estimatedDeliveryCost,
            info: StringAssets.amountOfWorkingDays(3),
          ),
          SizedBox(height: 120.ah),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RexFlatButton(
            onPressed: () =>
                ref.watch(cardNotifier.notifier).requestCard(context: context),
            buttonTitle: StringAssets.submitRequest,
            backgroundColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 15.ah),
        ],
      ),
    );
  }
}
