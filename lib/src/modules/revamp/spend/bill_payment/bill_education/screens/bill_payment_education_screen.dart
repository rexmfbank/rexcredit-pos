import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_education/widgets/education_new_payment.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_education/widgets/education_saved_payment.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_education/widgets/education_tabbar.dart';
import 'package:rex_app/src/modules/revamp/spend/widgets/account_balance_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BillPaymentEducationScreen extends StatefulHookConsumerWidget {
  const BillPaymentEducationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillPaymentEducationScreenState();
}

class _BillPaymentEducationScreenState
    extends ConsumerState<BillPaymentEducationScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2, vsync: this);
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Education',
        subtitle: 'Pay school fees from your account',
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const AccountBalanceCard(),
            EducationTabBar(tabController: tabController),
            const SizedBox(height: 16),
            Flexible(
              child: TabBarView(
                controller: tabController,
                children: const [
                  EducationNewPayment(),
                  EducationSavedPayment(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
