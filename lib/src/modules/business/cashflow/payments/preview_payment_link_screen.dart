import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/cashflow/payments/components/payment_link_created_modal.dart';
import 'package:rex_app/src/modules/business/cashflow/payments/components/preview_product_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class PreviewPaymentLinkScreen extends HookConsumerWidget {
  const PreviewPaymentLinkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Preview Payment Link',
        subtitle: 'Here is how your customer will see this page',
        hasActionButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: ListView(
          children: [
            const PreviewProductWidget(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  showPaymentLinkCreatedModal(
                      context,
                      'Product Added!',
                      'You have successfully added a product to your inventory',
                      'Ok',
                      'success_tick', () {
                    context.pop();
                    context.go(
                        '${Routes.dashboardBusiness}/${Routes.cashflowInventory}');
                  });
                },
                buttonTitle: 'Create Payment Link',
                backgroundColor: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
