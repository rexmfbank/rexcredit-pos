import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_adaptive_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmployeeWorkInformationScreen extends ConsumerStatefulWidget {
  final bool edit;
  const EmployeeWorkInformationScreen({super.key, this.edit = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeeWorkInformationScreenState();
}

class _EmployeeWorkInformationScreenState
    extends ConsumerState<EmployeeWorkInformationScreen> {
  @override
  void initState() {
    if (widget.edit) {
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
      resizeToAvoidBottomInset: true,
      appBar: const RexAppBar(
        stepValue: 2,
        totalStepValue: 4,
        shouldHaveBackButton: true,
        title: StringAssets.employeeWorkInfo,
        subtitle: StringAssets.employeeWorkInfoSub,
      ),
      body: Form(
        key: ref.watch(employeeNotifier).workInfoFormKey,
        child: ListView(
          children: [
            SizedBox(height: 10.ah),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.departmentTitle,
              hintText: StringAssets.enterDepartmentTitle,
              controller: ref.watch(employeeNotifier).departmentController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value) => TextfieldValidator.input(value),
            ),
            SizedBox(height: 10.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RexTextFieldRichText(
                    title1: StringAssets.paymentGroupTitle,
                    color1: AppColors.rexPurpleDark2,
                  ),
                  SizedBox(height: 7.ah),
                  RexAdaptiveDropdown<String>(
                    items: ref.watch(employeeNotifier).paymentGroups,
                    value: ref.watch(employeeNotifier).paymentGroup,
                    hint: 'Select payment group',
                    onChanged: (value) {
                      ref
                          .watch(employeeNotifier.notifier)
                          .updatePaymentGroup(value);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.ah),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.designationTitle,
              hintText: StringAssets.enterDesignationTitle,
              controller: ref.watch(employeeNotifier).designationController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value) => TextfieldValidator.input(value),
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                onPressed: () => ref
                    .watch(employeeNotifier.notifier)
                    .validateWorkInfo(context),
                buttonTitle: widget.edit
                    ? StringAssets.updateTextOnButton
                    : StringAssets.nextTextOnButton,
                backgroundColor: null,
              ),
            ),
            SizedBox(height: 35.ah),
          ],
        ),
      ),
    );
  }
}
