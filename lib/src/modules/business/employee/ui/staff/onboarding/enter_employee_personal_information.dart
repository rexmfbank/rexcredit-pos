import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/upload_document_widget.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class UpdateEmployeePersonalInformationScreen extends ConsumerStatefulWidget {
  final bool edit;

  const UpdateEmployeePersonalInformationScreen({super.key, this.edit = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateEmployeePersonalInformationScreenState();
}

class _UpdateEmployeePersonalInformationScreenState
    extends ConsumerState<UpdateEmployeePersonalInformationScreen> {
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
        stepValue: 1,
        totalStepValue: 4,
        shouldHaveBackButton: true,
        title: StringAssets.employeePersonalInfoTitle,
        subtitle: StringAssets.employeePersonalInfoSubtitle,
      ),
      body: Form(
        key: ref.watch(employeeNotifier).personalInfoFormKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: UploadDocumentWidget(
                title: StringAssets.uploadEmployeePhoto,
                uploadInstructions: StringAssets.uploadImageInstructions,
                allowedExtensions: const [
                  'png',
                  'jpg',
                  'jpeg',
                ],
                onUpload: (value) => ref
                    .watch(employeeNotifier.notifier)
                    .updateFileDetails(value),
              ),
            ),
            SizedBox(height: 10.ah),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.firstNameTitle,
              hintText: StringAssets.firstNameHint,
              controller: ref.watch(employeeNotifier).firstNameController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value) => TextfieldValidator.businessName(value),
            ),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.lastNameTitle,
              hintText: StringAssets.lastNameHint,
              controller: ref.watch(employeeNotifier).lastNameController,
              obscureText: false,
              inputType: TextInputType.text,
              validator: (value) => TextfieldValidator.businessName(value),
            ),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.phoneNumberTitle,
              hintText: StringAssets.phoneNumberHint,
              controller: ref.watch(employeeNotifier).phoneController,
              obscureText: false,
              inputType: TextInputType.phone,
              validator: (value) => TextfieldValidator.phoneNumber(value),
            ),
            RexTextField(
              showOuterTile: true,
              textFieldIsRequired: true,
              outerTitle: StringAssets.emailAddressTitle,
              hintText: StringAssets.emailAddressHint,
              controller: ref.watch(employeeNotifier).emailController,
              obscureText: false,
              inputType: TextInputType.emailAddress,
              validator: (value) => TextfieldValidator.email(value),
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                onPressed: () => widget.edit
                    ? ref
                        .watch(employeeNotifier.notifier)
                        .validateEditPersonalInfo(context)
                    : ref
                        .watch(employeeNotifier.notifier)
                        .validatePersonalInfo(context),
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
