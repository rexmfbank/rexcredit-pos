import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/customer_tier/customer_tier_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class CustomerTierWidget extends ConsumerWidget {
  const CustomerTierWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(customerTierProvider);
    return tier.when(
      data: (tierResponse) {
        if (tierResponse.data == null) {
          return const NullDataWidget();
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: tierResponse.data!.length,
          itemBuilder: (context, index) {
            return AccountLimitInfo(
              tranName: tierResponse.data![index].tranName,
              maxLimit: tierResponse.data![index].maxLimit,
              dailyLimit: tierResponse.data![index].dailyLimit,
              monthlyLimit: tierResponse.data![index].monthlyLimit,
            );
          },
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text('Could not fetch account limit information'),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class AccountLimitInfo extends StatelessWidget {
  const AccountLimitInfo({
    super.key,
    required this.tranName,
    required this.maxLimit,
    required this.dailyLimit,
    required this.monthlyLimit,
  });

  final String tranName;
  final double maxLimit;
  final double dailyLimit;
  final double monthlyLimit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 10.ah),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 16.ah),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "For $tranName",
                style: TextStyle(
                  fontSize: 14.asp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Daily Limit"),
                Text(dailyLimit.formatCurrencyNum()),
              ],
            ),
            SizedBox(height: 8.ah),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Maximum Limit"),
                Text(maxLimit.formatCurrencyNum()),
              ],
            ),
            SizedBox(height: 8.ah),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Monthly Limit"),
                Text(monthlyLimit.formatCurrencyNum()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NullDataWidget extends ConsumerWidget {
  const NullDataWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Divider(
          height: 40.ah,
          endIndent: 16.aw,
          indent: 16.aw,
        ),
        Center(
          child: Text(
            'No information on transaction limits',
            style: AppTextStyles.h2,
          ),
        ),
      ],
    );
  }
}
