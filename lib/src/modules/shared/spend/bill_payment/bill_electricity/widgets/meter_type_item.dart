import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/provider/electricity_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/string_utils.dart';

class MeterTypeItem extends ConsumerWidget {
  final BillerProduct product;
  const MeterTypeItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.watch(electricityProvider.notifier).setSelectedMeterType(
              context: context,
              product: product,
              meterProduct: '${product.productName.toTitleCase()}',
            );
        context.pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.aw, vertical: 4.ah),
        child: Column(
          children: [
            Text(
              '${product.productName.toTitleCase()}',
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.ah),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
