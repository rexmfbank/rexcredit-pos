import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/provider/request_pos_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import '../../profile/providers/get_profile_info_api_provider.dart';

class IndividualRequestPosScreen extends ConsumerStatefulWidget {
  const IndividualRequestPosScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualRequestPosScreenState();
}

class _IndividualRequestPosScreenState
    extends ConsumerState<IndividualRequestPosScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getProfileInfoProvider.notifier).getProfileInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const RexAppBar(
          step: null,
          shouldHaveBackButton: true,
          title: StringAssets.requestPosTitle,
          subtitle: StringAssets.requestPosSubtitle,
          hasActionButton: false,
        ),
        body: Stack(children: [
          Form(
            key: ref.watch(requestPOSProvider).formKey,
            child: ListView(
              children: [
                const SizedBox(height: 16),
                RexTextField(
                  outerTitle: StringAssets.contactPerson,
                  hintText: StringAssets.enterContactPerson,
                  controller:
                      ref.watch(requestPOSProvider).contactPersonController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.text,
                  hasInputFormat: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.emailAddressTitle,
                  hintText: StringAssets.emailAddressHint,
                  controller:
                      ref.watch(requestPOSProvider).emailAddressController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.emailAddress,
                  hasInputFormat: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.mobileNumberTitle,
                  hintText: StringAssets.phoneNumberHint,
                  controller:
                      ref.watch(requestPOSProvider).phoneNumberController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.phone,
                  hasInputFormat: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.bvnTitle,
                  hintText: StringAssets.bvnHint,
                  initialValue: ref.watch(userBVNProvider),
                  // controller: ref.watch(requestPOSProvider).bvnController,
                  obscureText: false,
                  showOuterTile: true,
                  readOnly: true,
                  backgroundColor: AppColors.grey2,
                ),
                RexTextField(
                  outerTitle: StringAssets.ninTitle,
                  hintText: StringAssets.ninHintText,
                  controller: ref.watch(requestPOSProvider).ninController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.number,
                  hasInputFormat: false,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.lineOfBusiness,
                  hintText: StringAssets.lineOfBusinessHint,
                  controller:
                      ref.watch(requestPOSProvider).lineOfBusinessController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.text,
                  hasInputFormat: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.settlementAccountName,
                  hintText: StringAssets.settlementAccountNameHint,
                  controller: ref
                      .watch(requestPOSProvider)
                      .settlementAccountNameController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.text,
                  hasInputFormat: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.settlementAccountNumber,
                  hintText: StringAssets.settlementAccountNumberHint,
                  controller: ref
                      .watch(requestPOSProvider)
                      .settlementAccountNumberController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.number,
                  hasInputFormat: false,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.settlementBankName,
                  hintText: StringAssets.settlementBankNameHint,
                  controller: ref
                      .watch(requestPOSProvider)
                      .settlementBankNameController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.text,
                  hasInputFormat: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                RexTextField(
                  outerTitle: StringAssets.posAddressTitle,
                  hintText: StringAssets.posAddressHint,
                  controller:
                      ref.watch(requestPOSProvider).physicalAddressController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.text,
                  hasInputFormat: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: RexFlatButton(
                    onPressed: () {
                      ref
                          .read(requestPOSProvider.notifier)
                          .validatePosRequestDetails(context);
                    },
                    buttonTitle: StringAssets.submitTextOnButton,
                    backgroundColor: AppColors.rexLightBlue2,
                    borderColor: AppColors.rexLightBlue2,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          if (ref.watch(requestPOSProvider).isLoading)
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ]));
  }
}
