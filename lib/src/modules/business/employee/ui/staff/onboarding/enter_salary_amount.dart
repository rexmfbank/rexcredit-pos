import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/custom_dropdown_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmployeeSalaryAmountScreen extends ConsumerStatefulWidget {
  final bool edit;
  const EmployeeSalaryAmountScreen({super.key, this.edit = false});

  @override
  ConsumerState<EmployeeSalaryAmountScreen> createState() => _EmployeeSalaryAmountScreenState();
}

class _EmployeeSalaryAmountScreenState extends ConsumerState<EmployeeSalaryAmountScreen> {

  @override
  void initState() {
    if(widget.edit){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(employeeNotifier.notifier).clearFields().then(
                (value) => ref.read(employeeNotifier.notifier).fillFields(context));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(employeeNotifier).isLoading,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const RexAppBar(
        stepValue: 3,
        totalStepValue: 4,
        showProfileImage: false,
        shouldHaveBackButton: true,
        title: StringAssets.salaryAmount,
        subtitle: StringAssets.salaryAmountSub,
      ),
      body: Form(
        key: ref.watch(employeeNotifier).salaryInfoFormKey,
        child: ListView(
          children: [
            SizedBox(height: 8.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RexTextFieldRichText(
                    title1: StringAssets.currency,
                    color1: AppColors.textBlack,
                  ),
                  SizedBox(height: 7.ah),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.ar),
                    child: CustomDropDownButton(
                      height: 56.ah,
                      items: const ['NGN', 'USD', 'GBP'],
                      backGroundColor: AppColors.rexWhite,
                      dropdownValue:
                          ValueNotifier(ref.watch(employeeNotifier).currency),
                      withHint: false,
                      onChanged: (String? value) => ref
                          .watch(employeeNotifier.notifier)
                          .updateCurrency(value),
                      validationError: ValueNotifier(TextfieldValidator.input(
                        ref.watch(employeeNotifier).currency,
                        StringAssets.invalidCurrency,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.ah),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.monthlyGrossSalary,
              hintText: StringAssets.enterMonthlyGrossSalary,
              controller: ref.watch(employeeNotifier).grossSalaryController,
              obscureText: false,
              inputType: const TextInputType.numberWithOptions(decimal: true),
              hasInputFormat: true,
              validator: (value) => TextfieldValidator.minAmount(
                minAmount: 5,
                value: value,
              ),
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                onPressed: () => ref
                    .watch(employeeNotifier.notifier)
                    .validateSalaryInfo(context),
                buttonTitle: widget.edit
                    ? StringAssets.updateTextOnButton
                    : StringAssets.nextTextOnButton,
                backgroundColor: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
