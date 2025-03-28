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

class EmployeeAllowancesScreen extends ConsumerStatefulWidget {
  final bool edit;
  const EmployeeAllowancesScreen({super.key, this.edit = false});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeeAllowancesScreenState();
}

class _EmployeeAllowancesScreenState
    extends ConsumerState<EmployeeAllowancesScreen> {

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
        title: StringAssets.allowances,
        subtitle: StringAssets.employeeSalaryInfoSub,
      ),
      body: Form(
        key: ref.watch(employeeNotifier).allowanceInfoFormKey,
        child: ListView(
          children: [
            RexTextField(
              prefixIcon: const RexTextFieldCurrencyWidget(),
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.amount,
              hintText: StringAssets.enterAmount,
              controller: ref.watch(employeeNotifier).allowanceController,
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
              controller: ref.watch(employeeNotifier).allowanceDescriptionController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value)=> TextfieldValidator.input(value),
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                verticalPadding: 8.ah,
                onPressed: ()=> ref.watch(employeeNotifier.notifier).validateAddAllowance(context),
                buttonTitle: StringAssets.addAllowance,
                backgroundColor: AppColors.rexTint700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                verticalPadding: 8.ah,
                onPressed: ()=> ref.watch(employeeNotifier.notifier).validateCloseAllowances(context),
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
