import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/more/profile/ui/screens/personal_profile_screen.dart';
import 'package:rex_app/src/modules/shared/customer_tier/customer_tier_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CustomerProfileTier extends ConsumerWidget {
  const CustomerProfileTier({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(customerTierProvider);
    return tier.when(
      data: (data) => ProfileText(
        title: StringAssets.accountTier,
        value: data.customerType,
      ),
      error: (error, stackTrace) => const ProfileText(
        title: StringAssets.accountTier,
        value: 'N/A',
      ),
      loading: () => const ProfileText(
        title: StringAssets.accountTier,
        value: '***',
      ),
    );
  }
}
