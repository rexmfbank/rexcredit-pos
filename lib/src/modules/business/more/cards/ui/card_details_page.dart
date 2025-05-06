import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/components/summary_row.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CardDetailsPage extends StatelessWidget {
  final CardDetails model;
  const CardDetailsPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        title: StringAssets.cardDetails,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SummaryRow(
            title: StringAssets.cardName,
            info: model.nameOnCard ?? 'n/a',
          ),
          SummaryRow(
            title: StringAssets.cardNumber,
            info: model.fullCardNumber?.replaceRange(0, 11, '**** **** ****') ??
                '**** **** ****',
          ),
          SummaryRow(
            title: StringAssets.cvv,
            info: model.cvv ?? 'n/a',
          ),
          SummaryRow(
            title: StringAssets.expiryDate,
            info: DateFormat('M/y').format(model.expiryDate ?? DateTime.now()),
          ),
        ],
      ),
    );
  }
}
