import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/business_directors/components/directors_gender_dropdown.dart';
import 'package:rex_app/src/modules/business/more/profile/business_directors/providers/add_business_director_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/business_director_id_card_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/business_director_id_upload.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/provider/add_director_state_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AddDirectorForm extends StatefulHookConsumerWidget {
  const AddDirectorForm({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<StatefulHookConsumerWidget> createState() =>
      _BusinessDirectorFormState();
}

class _BusinessDirectorFormState extends ConsumerState<AddDirectorForm> {
  bool tileExpanded = false;

  void loadingAction() {
    ref.listen(
      addBusinessDirectorsProvider,
      (_, state) {
        state.when(
          data: (data) {
            LoadingScreen.instance().hide();
            showModalAction(
                context: context,
                dialogTitle: StringAssets.businessDirectorDetailsTitle,
                dialogSubtitle: StringAssets.businessDirectorDetailsSubtitle,
                buttonTitle: StringAssets.ok,
                onPressed: () {
                  context.pop();
                  context.pop();
                  context.pop();
                  context.push(
                    "${Routes.dashboardMoreBusiness}/${Routes.addBusinessDirector}",
                  );
                });
          },
          error: (error, stackTrace) {
            LoadingScreen.instance().hide();
            showModalActionError(
              context: context,
              errorText: error.toString(),
            );
          },
          loading: () {
            LoadingScreen.instance().show(context: context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access director object using widget.director
    final addDirectorInfo = ref.watch(addDirectorStateProvider);

    //
    loadingAction();
    //

    return AppScaffold(
      padding: EdgeInsets.symmetric(horizontal: 12.aw),
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.addDirectorTitle,
        subtitle: StringAssets.addDirectorSubtitle,
      ),
      body: Form(
        key: addDirectorInfo.formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.ah),
            const RexTextFieldRichText(title1: StringAssets.firstNameTitle),
            SizedBox(height: 3.ah),
            RexTextField(
              horizontalPadding: 0,
              showOuterTile: false,
              hintText: StringAssets.firstNameHint,
              controller: addDirectorInfo.firstNameController,
              obscureText: false,
              validator: (value) => TextfieldValidator.name(value),
            ),
            SizedBox(height: 10.ah),
            const RexTextFieldRichText(title1: StringAssets.middleNameTitle),
            SizedBox(height: 3.ah),
            RexTextField(
              horizontalPadding: 0,
              showOuterTile: false,
              hintText: StringAssets.middleNameHint,
              controller: addDirectorInfo.middleNameController,
              obscureText: false,
              validator: (value) => TextfieldValidator.name(value),
            ),
            SizedBox(height: 10.ah),
            const RexTextFieldRichText(title1: StringAssets.lastNameTitle),
            SizedBox(height: 3.ah),
            RexTextField(
              horizontalPadding: 0,
              showOuterTile: false,
              hintText: StringAssets.lastNameHint,
              controller: addDirectorInfo.lastNameController,
              obscureText: false,
              validator: (value) => TextfieldValidator.name(value),
            ),
            SizedBox(height: 10.ah),
            const RexTextFieldRichText(title1: StringAssets.emailAddressTitle),
            SizedBox(height: 3.ah),
            RexTextField(
              horizontalPadding: 0,
              showOuterTile: false,
              hintText: StringAssets.emailAddressHint,
              controller: addDirectorInfo.emailController,
              obscureText: false,
              validator: (value) => TextfieldValidator.email(value),
            ),
            SizedBox(height: 10.ah),
            const DirectorGenderDropdown(),
            SizedBox(height: 18.ah),
            const RexTextFieldRichText(title1: StringAssets.phoneNumberTitle),
            SizedBox(height: 3.ah),
            RexTextField(
              horizontalPadding: 0,
              showOuterTile: false,
              hintText: StringAssets.phoneNumberHint,
              controller: addDirectorInfo.mobileNoController,
              obscureText: false,
              validator: (value) => TextfieldValidator.phoneNumber(value),
              inputType: TextInputType.phone,
            ),
            SizedBox(height: 10.ah),
            const RexTextFieldRichText(title1: StringAssets.bvnTitle),
            SizedBox(height: 3.ah),
            RexTextField(
              horizontalPadding: 0,
              showOuterTile: false,
              hintText: StringAssets.bvnHint,
              controller: addDirectorInfo.bvnController,
              obscureText: false,
              maxLength: 11,
              validator: (value) => TextfieldValidator.bvn(value),
              inputType: TextInputType.number,
            ),
            SizedBox(height: 10.ah),
            const RexTextFieldRichText(title1: StringAssets.sharesOwned),
            SizedBox(height: 3.ah),
            RexTextField(
              horizontalPadding: 0,
              showOuterTile: false,
              hintText: '',
              controller: addDirectorInfo.sharesController,
              obscureText: false,
              validator: (value) => TextfieldValidator.input(value),
              inputType: TextInputType.number,
            ),
            SizedBox(height: 10.ah),
            const RexTextFieldRichText(title1: StringAssets.dobText),
            SizedBox(height: 3.ah),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2006),
                  ).then((value) {
                    ref
                        .read(addDirectorStateProvider.notifier)
                        .onDateSelectionChange(value);
                  });
                },
                child: RexTextField(
                  horizontalPadding: 0,
                  obscureText: false,
                  hintText: addDirectorInfo.dateOfBirth != null
                      ? DateFormat.yMMMd().format(addDirectorInfo.dateOfBirth!)
                      : '',
                  controller: addDirectorInfo.dobController,
                  showOuterTile: false,
                  enabled: false,
                ),
              ),
            ),
            SizedBox(height: 10.ah),
            const BusinessDirectorIdCardDropdown(),
            SizedBox(height: 18.ah),
            const BusinessDirectorIdUpload(),
            SizedBox(height: 30.ah),
            RexElevatedButton(
              onPressed: () => ref
                  .watch(addDirectorStateProvider.notifier)
                  .addBusinessDirector(context),
              buttonTitle: StringAssets.saveText,
              backgroundColor: AppColors.rexLightBlue3,
            ),
            SizedBox(height: 30.ah),
          ],
        ),
      ),
    );
  }
}
