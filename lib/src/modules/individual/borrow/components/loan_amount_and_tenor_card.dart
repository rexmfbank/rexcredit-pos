import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_calculation_provider.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_products_provider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_savings_duration_slider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoanAmountAndTenorCard extends StatefulHookConsumerWidget {
  const LoanAmountAndTenorCard({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoanAmountAndTenorCardState();
}

class _LoanAmountAndTenorCardState
    extends ConsumerState<LoanAmountAndTenorCard> {
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    final loanProduct = ref.watch(loanProductsProvider).selectedLoanProduct ??
        const LoanProductModel.empty();
    var sliderValue = useState<double>(loanProduct.minTenor!.toDouble());
    final minLoanAmount = loanProduct.minPrincipalAmount ?? 0;
    final maxLoanAmount = loanProduct.maxPrincipalAmount ?? 0;
    final showSlider = loanProduct.maxTenor! > loanProduct.minTenor!;

    void calculateLoanRepaymentAmount() {
      ref.read(loanCalculationProvider.notifier).updateApiError();
      var tenor = ref.watch(loanCalculationProvider).selectedTenor;
      if (tenor.isEmpty || tenor == "1") {
        ref
            .read(loanCalculationProvider.notifier)
            .setSelectedTenor(loanProduct.minTenor.toString());
      }
      ref.read(loanCalculationProvider.notifier).validateLoanAmount(
            context,
            minLoanAmount,
            maxLoanAmount,
          );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.aw),
      padding: EdgeInsets.all(8.ar),
      decoration: const BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          RexTextField(
            outerTitle: StringAssets.loanAmount,
            hintText: StringAssets.enterAmount,
            controller: ref.watch(loanCalculationProvider).loanAmountController,
            obscureText: false,
            inputType: TextInputType.number,
            // focusNode: ref.watch(loanCalculationProvider).loanAmountFocusNode,
            backgroundColor: AppColors.rexBackground,
            validator: (value) => TextfieldValidator.loanAmount(
              value,
              maxLoanAmount,
              minLoanAmount,
            ),
            onChanged: (value) {
              _debounceTimer?.cancel();
              _debounceTimer = Timer(const Duration(milliseconds: 1500), () {
                if (value.length > 3) calculateLoanRepaymentAmount();
              });
            },
            onEditingComplete: () {
              calculateLoanRepaymentAmount();
            },
          ),
          SizedBox(height: 10.ah),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.aw, vertical: 8.ah),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    StringAssets.tenor,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.asp,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.aw),
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: AppColors.cardGreen,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  showSlider
                      ? '${sliderValue.value.toInt()} ${getTenorPeriod(loanProduct.tenorPeriod ?? '')}'
                      : '${loanProduct.minTenor?.toInt()} ${getTenorPeriod(loanProduct.tenorPeriod ?? '')}',
                  style: const TextStyle(
                      color: AppColors.rexGreen, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          showSlider
              ? CustomSavingsDurationSlider(
                  min: showSlider ? loanProduct.minTenor!.toDouble() : 0.0,
                  max: showSlider ? loanProduct.maxTenor!.toDouble() : 6.0,
                  value: sliderValue.value,
                  onChanged: (value) {
                    sliderValue.value = value;
                    ref.read(loanCalculationProvider.notifier).updateApiError();
                    _debounceTimer?.cancel();
                    _debounceTimer = Timer(
                      const Duration(milliseconds: 1500),
                      () {
                        ref
                            .read(loanCalculationProvider.notifier)
                            .setSelectedTenor(value.toInt().toString());
                        ref
                            .read(loanCalculationProvider.notifier)
                            .validateLoanAmount(
                              context,
                              minLoanAmount,
                              maxLoanAmount,
                            );
                      },
                    );
                  },
                )
              : Container(
                  height: 8,
                ),
        ],
      ),
    );
  }

  String getTenorPeriod(String? type) {
    if (type == null) {
      throw ArgumentError('Tenor Period cannot be null');
    }

    switch (type.toUpperCase()) {
      case 'DAILY':
        return 'Day(s)';
      case 'MONTHLY':
        return 'Month(s)';
      case 'WEEKLY':
        return 'Week(s)';
      case 'QUARTERLY':
        return 'Quarter(s)';
      case 'YEARLY':
        return 'Year(s)';
      default:
        return 'Days(s)';
    }
  }

  // void focusNodeListener(LoanProductModel loanProduct, double minLoanAmount,
  //     double maxLoanAmount) {
  //   ref.listen(loanCalculationProvider, (previous, next) {
  //     if (!next.loanAmountFocusNode.hasFocus &&
  //         next.loanAmountController.text.isNotBlank) {
  //       ref.read(loanCalculationProvider.notifier).updateApiError();
  //       var tenor = ref.watch(loanCalculationProvider).selectedTenor;
  //       if (tenor.isEmpty || tenor == "1") {
  //         ref
  //             .read(loanCalculationProvider.notifier)
  //             .setSelectedTenor(loanProduct.minTenor.toString());
  //       }
  //       ref.read(loanCalculationProvider.notifier).validateLoanAmount(
  //             context,
  //             minLoanAmount,
  //             maxLoanAmount,
  //           );
  //     }
  //   });
  // }
}
