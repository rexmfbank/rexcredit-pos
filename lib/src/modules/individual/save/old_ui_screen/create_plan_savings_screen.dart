import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_savings_duration_slider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_checked_box.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CreatePlanSavingsScreen extends StatefulHookConsumerWidget {
  const CreatePlanSavingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateSavingsPlanScreenState();
}

class _CreateSavingsPlanScreenState
    extends ConsumerState<CreatePlanSavingsScreen> {
  final _formKey = GlobalKey<FormState>();

  bool? isYesChecked = false;
  bool autoSave = false;
  bool? isNoChecked = false;
  DateTime? selectedDate;
  double sliderValue = 1.0;
  bool isPlanNameValidationLoading = false;
  String? selectedFrequency = 'Monthly';

  void handleFrequencyChanged(String? newValue) {
    setState(() {
      selectedFrequency = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final savingsPlanNameController = useTextEditingController();
    final savingsPlanTargetAmountController = useTextEditingController();
    final savingsPlanDepositAmountController = useTextEditingController();

    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    final logger = ref.watch(loggerProvider);

    String validatePlanErrorMessage = '';
    Timer? validatePlanRequestTimer;

    void startRequestTimer(String userInput) {
      // Clear previous error message
      setState(() {
        validatePlanErrorMessage = '';
      });

      // Cancel the previous timer, if any
      validatePlanRequestTimer?.cancel();

      // Start a new timer to delay the request
      validatePlanRequestTimer =
          Timer(const Duration(milliseconds: 2000), () {});
    }

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.createSavingsPlanTitle,
        subtitle: StringAssets.createSavingsPlanSubtitle,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            RexTextField(
              outerTitle: StringAssets.createSavingsPlanNameText,
              hintText: StringAssets.savingsPlanNameHint,
              controller: savingsPlanNameController,
              obscureText: false,
              inputType: TextInputType.name,
              onChanged: (value) {
                startRequestTimer(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a savings plan name';
                } else if (validatePlanErrorMessage != '') {
                  return validatePlanErrorMessage;
                }
                return null;
              },
            ),
            isPlanNameValidationLoading
                ? const Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 8.0,
                      width: 8.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                  )
                : Container(),
            RexTextField(
              prefixIcon: const RexTextFieldCurrencyWidget(),
              outerTitle: StringAssets.createSavingsPlanTargetAmountText,
              hintText: StringAssets.savingsPlanTargetAmountHint,
              controller: savingsPlanTargetAmountController,
              obscureText: false,
              inputType: TextInputType.number,
              hasInputFormat: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a target amount';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 24.0, bottom: 24),
              child: Text(
                StringAssets.createSavingsPlanDurationAmountText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: AppColors.rexPurpleDark,
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Text(
                'Do you want to auto-save?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: AppColors.rexPurpleDark,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: CustomCheckedBoxWidget(
                      text: 'Yes',
                      isChecked: isYesChecked!,
                      onChanged: (bool? isCheckedValue) {
                        setState(() {
                          isYesChecked = isCheckedValue;
                          autoSave = isYesChecked!;
                          isNoChecked = !isCheckedValue!;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: CustomCheckedBoxWidget(
                      text: 'No',
                      isChecked: isNoChecked!,
                      onChanged: (isChecked) {
                        setState(() {
                          isNoChecked = isChecked;
                          isYesChecked = !isChecked!;
                          autoSave = isYesChecked!;
                          selectedDate = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            isYesChecked == true
                ? RexCustomSpinner(
                    title: 'How often do you want to save?',
                    options: const ['Daily', 'Weekly', 'Monthly'],
                    onOptionChanged: handleFrequencyChanged,
                  )
                : Container(),
            RexTextField(
              prefixIcon: const RexTextFieldCurrencyWidget(),
              outerTitle: StringAssets.createSavingsPlanDepositAmountText,
              hintText: '40,500',
              controller: savingsPlanDepositAmountController,
              obscureText: false,
              inputType: TextInputType.number,
              hasInputFormat: true,
            ),
            isYesChecked == true
                ? const Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                    child: Text(
                      'When should automatic savings start?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                  )
                : Container(),
            isYesChecked == true
                ? GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            this.selectedDate = selectedDate;
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        selectedDate != null
                            ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                            : 'Select Date',
                        style: TextStyle(
                          color: AppColors.rexTint500,
                        ),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    final selectedDateString = selectedDate != null
                        ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                        : '';
                  }
                },
                buttonTitle: StringAssets.nextTextOnButton,
                backgroundColor: _formKey.currentState?.validate() == true
                    ? null
                    : AppColors.cardGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
