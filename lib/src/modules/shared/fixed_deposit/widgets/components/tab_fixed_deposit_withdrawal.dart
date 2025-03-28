import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class TabFixedDepositWithdrawal extends ConsumerWidget {
  const TabFixedDepositWithdrawal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          'Not available',
          style: AppTextStyles.bodyRegularSize14,
        ),
      ),
    );
  }
}
