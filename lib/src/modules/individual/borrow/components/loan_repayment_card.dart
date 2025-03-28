import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_savings_duration_slider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class LoanRepaymentAmountCard extends StatefulHookConsumerWidget {
  final String amount;

  const LoanRepaymentAmountCard({super.key, required this.amount});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoanRepaymentAmountCardState();
}

class _LoanRepaymentAmountCardState
    extends ConsumerState<LoanRepaymentAmountCard> {
  @override
  Widget build(BuildContext context) {
    final loanAmountController = useTextEditingController();

    var sliderValue = 1.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          RexTextField(
            outerTitle: 'Loan Amount',
            hintText: '₦50,000',
            controller: loanAmountController,
            obscureText: false,
            backgroundColor: AppColors.rexBackground,
            showOuterTile: true,
            validator: (value) => TextfieldValidator.amount(value),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tenor',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
          CustomSavingsDurationSlider(
            min: 0,
            max: 12,
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
