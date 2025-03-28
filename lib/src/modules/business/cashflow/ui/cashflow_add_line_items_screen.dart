import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/cashflow/providers/line_item_provider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class CashflowAddLineItemsScreen extends HookConsumerWidget {
  const CashflowAddLineItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingsPlanNameController = useTextEditingController();
    final savingsPlanTargetAmountController = useTextEditingController();

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Add Line Items',
        subtitle: 'Add all relevant details to your invoice',
      ),
      body: ListView(
        children: [
          RexTextField(
            outerTitle: 'Line Item',
            hintText: 'Enter Line Item',
            controller: savingsPlanNameController,
            obscureText: false,
            inputType: TextInputType.name,
            onChanged: (value) {},
            validator: (value) {
              return null;
            },
          ),
          RexTextField(
            prefixIcon: const RexTextFieldCurrencyWidget(),
            outerTitle: 'Unit Price',
            hintText: 'Enter unit Price',
            controller: savingsPlanNameController,
            obscureText: false,
            inputType: TextInputType.number,
            validator: (value) {
              return null;
            },
          ),
          RexTextField(
            outerTitle: 'Quantity',
            hintText: 'Enter Quantity',
            controller: savingsPlanTargetAmountController,
            obscureText: false,
            inputType: TextInputType.number,
            hasInputFormat: true,
            validator: (value) {
              return null;
            },
          ),
          const RexCustomSpinner(
              options: ['Percentage'], title: 'Discount Type'),
          const SizedBox(height: 8),
          RexTextField(
            outerTitle: 'Percentage Discount',
            hintText: '20%',
            controller: savingsPlanNameController,
            obscureText: false,
            inputType: const TextInputType.numberWithOptions(),
            validator: (value) {
              return null;
            },
          ),
          RexTextField(
            outerTitle: 'Tax',
            hintText: 'Enter tax percentage',
            controller: savingsPlanNameController,
            obscureText: false,
            inputType: TextInputType.number,
            validator: (value) {
              return null;
            },
          ),
          const LineItemDetailsWidget(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RexFlatButton(
                onPressed: () {
                  const newLineItem = LineItem(
                      title: 'Line Item 1',
                      amount: 320000,
                      quantity: 2,
                      taxTotal: 9.0);
                  ref.read(lineItemProvider.notifier).addLineItem(newLineItem);
                  context.pop();
                },
                buttonTitle: 'Save',
                backgroundColor: null),
          )
        ],
      ),
    );
  }
}

class LineItemDetailsWidget extends StatelessWidget {
  const LineItemDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.rexPurpleDark),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Discount',
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'N5,230',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 2, child: Text('Subtotal')),
              Flexible(
                flex: 1,
                child: Text(
                  'N15,230',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Tax Amount'),
              Text(
                'N5,230',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
          PlanSummaryDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total'),
              Text(
                'N15,230',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
