import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/cashflow/payments/components/payment_link_created_modal.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class CreatePaymentLinkScreen extends StatefulHookConsumerWidget {
  const CreatePaymentLinkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreatePaymentLinkScreenState();
  }
}

class _CreatePaymentLinkScreenState
    extends ConsumerState<CreatePaymentLinkScreen> {
  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Create payment link',
        subtitle: 'Add details of the payment you want to receive',
        hasActionButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: ListView(
          children: [
            RexTextField(
              outerTitle: 'Title',
              hintText: 'Enter Payment Title',
              controller: titleController,
              obscureText: false,
              inputType: TextInputType.name,
              validator: (value) {},
            ),
            RexTextField(
              outerTitle: 'Description',
              hintText: 'Enter Product Description',
              controller: descriptionController,
              obscureText: false,
              inputType: TextInputType.name,
              validator: (value) {},
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  context.push(
                      '${Routes.dashboardBusiness}/${Routes.previewPaymentLink}');
                },
                buttonTitle: 'Preview',
                textColor: AppColors.rexPurpleDark,
                backgroundColor: AppColors.rexBackground,
              ),
            ),
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
                backgroundColor: AppColors.rexLightBlue2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
