import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';

import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EmployeeBankInformationScreen extends ConsumerStatefulWidget {
  final bool edit;

  const EmployeeBankInformationScreen({super.key, this.edit = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeeBankInformationScreenState();
}

class _EmployeeBankInformationScreenState
    extends ConsumerState<EmployeeBankInformationScreen> {

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
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(employeeNotifier).isLoading,
      resizeToAvoidBottomInset: true,
      appBar: const RexAppBar(
        stepValue: 4,
        totalStepValue: 4,
        shouldHaveBackButton: true,
        title: StringAssets.bankInformation,
        subtitle: StringAssets.bankInformationSub,
      ),
      body: Form(
        key: ref.watch(employeeNotifier).bankInfoFormKey,
        child: ListView(
          children: [
            RexTextField(
              textFieldIsRequired: true,
              showOuterTile: true,
              readOnly: true,
              outerTitle: StringAssets.bankName,
              hintText: StringAssets.selectBank,
              controller: ref.watch(employeeNotifier).bankNameController,
              obscureText: false,
              validator: (value) => TextfieldValidator.input(value),
              onTap: () => ref
                  .watch(employeeNotifier.notifier)
                  .showBankList(context),
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                size: 25.ar,
                color: AppColors.textGrey,
              ),
            ),
            SizedBox(height: 8.ah),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.accountName,
              hintText: StringAssets.accountName,
              controller: ref
                  .watch(employeeNotifier)
                  .accountNameController,
              obscureText: false,
              validator: (value) => TextfieldValidator.input(value),
            ),
            SizedBox(height: 8.ah),
            RexTextField(
              textFieldIsRequired: true,
              showOuterTile: true,
              maxLength: 10,
              outerTitle: StringAssets.accountNumber,
              hintText: StringAssets.accountNumberHint,
              controller: ref
                  .watch(employeeNotifier)
                  .accountNumberController,
              obscureText: false,
              inputType: TextInputType.number,
              hasInputFormat: false,
              validator: (value) =>
                  TextfieldValidator.walletNumber(value),
            ),
            SizedBox(height: 8.ah),
            RexTextField(
              showOuterTile: true,
              maxLength: 10,
              outerTitle: StringAssets.swiftCode,
              hintText: StringAssets.swiftCodeHint,
              controller: ref
                  .watch(employeeNotifier)
                  .swiftCodeController,
              obscureText: false,
              inputType: TextInputType.number,
              hasInputFormat: false,
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                onPressed: ()=> ref.watch(employeeNotifier.notifier).validateBankInfo(context),
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
