import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmployeeDeductionsScreen extends ConsumerStatefulWidget {
  final bool edit;
  const EmployeeDeductionsScreen({super.key, this.edit = false});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeeDeductionsScreenState();
}

class _EmployeeDeductionsScreenState
    extends ConsumerState<EmployeeDeductionsScreen> {

  @override
  void initState() {
    if(widget.edit){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(employeeNotifier.notifier).clearFields();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const RexAppBar(
        stepValue: 3,
        totalStepValue: 4,
        shouldHaveBackButton: true,
        title: StringAssets.deductions,
        subtitle: StringAssets.employeeSalaryInfoSub,
      ),
      body: Form(
        key: ref.watch(employeeNotifier).deductionInfoFormKey,
        child: ListView(
          children: [
            RexTextField(
              prefixIcon: const RexTextFieldCurrencyWidget(),
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.amount,
              hintText: StringAssets.enterAmount,
              controller: ref.watch(employeeNotifier).deductionController,
              obscureText: false,
              inputType: const TextInputType.numberWithOptions(decimal: true),
              hasInputFormat: true,
              validator: (value) => TextfieldValidator.minAmount(
                minAmount: 5,
                value: value,
              ),
            ),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.description,
              hintText: StringAssets.enterDescription,
              controller: ref.watch(employeeNotifier).deductionDescriptionController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value)=> TextfieldValidator.input(value),
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                verticalPadding: 8.ah,
                onPressed: ()=> ref.watch(employeeNotifier.notifier).validateAddDeduction(context),
                buttonTitle: StringAssets.addDeduction,
                backgroundColor: AppColors.rexTint700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                verticalPadding: 8.ah,
                onPressed: ()=> ref.watch(employeeNotifier.notifier).validateCloseDeductions(context),
                buttonTitle: StringAssets.nextTextOnButton,
                backgroundColor: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
