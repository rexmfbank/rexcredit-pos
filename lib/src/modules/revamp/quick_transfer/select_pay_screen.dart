import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class SelectPayScreen extends ConsumerStatefulWidget {
  const SelectPayScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectPayScreenState();
}

class _SelectPayScreenState extends ConsumerState<SelectPayScreen> {
  @override
  void deactivate() {
    ref.read(posCardPurchaseProvider.notifier).resetNotificationState();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'Select Pay Method'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            RexElevatedButton(
              onPressed: () => context.push(Routes.nfcReaderScreen),
              buttonTitle: 'Pay with NFC',
            ),
            const SizedBox(height: 24),
            RexElevatedButton(
              onPressed: () {
                ref
                    .read(posCardPurchaseProvider.notifier)
                    .doCardPurchase(context: context, quickPurchase: true);
              },
              buttonTitle: 'Pay with Card',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
