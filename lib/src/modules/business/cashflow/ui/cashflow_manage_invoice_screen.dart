import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/cashflow/providers/line_item_provider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class CashFlowManageInvoiceScreen extends HookConsumerWidget {
  const CashFlowManageInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingsPlanNameController = useTextEditingController();
    final savingsPlanTargetAmountController = useTextEditingController();
    final lineItems = ref.watch(lineItemProvider);

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Manage Invoice',
        subtitle: 'Customize your invoice form with Rex',
      ),
      body: ListView(
        children: [
          const InvoiceLogoHeaderWidget(),
          RexTextField(
            outerTitle: 'Issue Date',
            hintText: '26 Nov 1998',
            controller: savingsPlanNameController,
            obscureText: false,
            inputType: TextInputType.name,
            onChanged: (value) {},
            validator: (value) {
              return null;
            },
          ),
          RexTextField(
            outerTitle: 'Due Date',
            hintText: '26 Nov 1998',
            controller: savingsPlanNameController,
            obscureText: false,
            inputType: TextInputType.name,
            validator: (value) {
              return null;
            },
          ),
          RexTextField(
            prefixIcon: const RexTextFieldCurrencyWidget(),
            outerTitle: 'Customer\'s Name',
            hintText: 'Enter Name',
            controller: savingsPlanTargetAmountController,
            obscureText: false,
            inputType: TextInputType.number,
            hasInputFormat: true,
            validator: (value) {
              return null;
            },
          ),
          RexTextField(
            outerTitle: 'Customer\'s Email',
            hintText: 'Enter email',
            controller: savingsPlanNameController,
            obscureText: false,
            inputType: TextInputType.emailAddress,
            validator: (value) {
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                context.push(
                    '${RouteName.dashboardBusiness}/${RouteName.addLineItems}');
              },
              buttonTitle: 'Add Line Item',
              backgroundColor: AppColors.rexLightBlue2,
              borderColor: AppColors.rexLightBlue2,
            ),
          ),
          if (lineItems.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...lineItems
                .map((item) => LineItemContainer(key: key, item: item))
                .toList(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  // Perform preview invoice action
                  context.push(
                      '${RouteName.dashboardBusiness}/${RouteName.cashflowPreviewInvoice}');
                },
                buttonTitle: 'Preview Invoice',
                textColor: AppColors.rexPurpleDark,
                backgroundColor: AppColors.rexBackground,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  // Perform create invoice action
                },
                buttonTitle: 'Create Invoice',
                backgroundColor: null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class InvoiceLogoHeaderWidget extends StatelessWidget {
  const InvoiceLogoHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/png/rex_circle_logo.png',
            height: 60,
            width: 60,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rex Africa',
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Rexfinance@Rex.co',
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              )
            ],
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Invoice No: #00001',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LineItemContainer extends StatelessWidget {
  final LineItem item;

  const LineItemContainer({required Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Amount: ${item.amount}',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'Quantity: ${item.quantity}',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'Tax Total: ${item.taxTotal}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
