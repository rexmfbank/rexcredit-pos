import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class SelectPayScreen extends ConsumerStatefulWidget {
  const SelectPayScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectPayScreenState();
}

class _SelectPayScreenState extends ConsumerState<SelectPayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Pay Method')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RexElevatedButton(onPressed: () {}, buttonTitle: 'Pay with NFC'),
            SizedBox(height: 16),
            RexElevatedButton(
              onPressed:
                  () => ref
                      .read(posCardPurchaseProvider.notifier)
                      .doCardPurchaseV2(context: context, quickPurchase: true),
              buttonTitle: 'Pay with Card',
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
