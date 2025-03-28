import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/providers/business_info_screen_provider.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/get_profile_info_api_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_lga_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_logo_upload.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_state_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import '../../../../../shared/widgets/dropdown/rex_custom_dropdown_widget.dart';

class EditBusinessInfoScreen extends ConsumerStatefulWidget {
  const EditBusinessInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditBusinessInfoScreen();
}

class _EditBusinessInfoScreen extends ConsumerState<EditBusinessInfoScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getProfileInfoProvider.notifier).getProfileInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(fetchProfileInformationProvider);
    final businessInfoModel = ref.watch(businessInfoProvider);
    //
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: '',
        title: StringAssets.businessInfoTitle,
        subtitle: StringAssets.businessInfoSubtitle,
      ),
      body: profileData.when(
        data: (data) {
          businessInfoModel.businessNameController.text =
              data?.business?.businessName ?? '';
          businessInfoModel.businessEmailController.text =
              data?.business?.businessEmail ?? '';
          businessInfoModel.businessPhoneController.text =
              data?.business?.businessMobileNo ?? '';
          businessInfoModel.businessAddressController.text =
              data?.business?.businessAddress ?? '';
          businessInfoModel.businessRegNumberController.text =
              data?.business?.businessCode ?? '';
          businessInfoModel.businessYearsInLocationController.text = ref
              .read(businessInfoProvider.notifier)
              .yearsAgo(data?.business?.businessStartYear);
          return Form(
            key: businessInfoModel.formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const BusinessLogoUpload(),
                SizedBox(height: 8.ah),
                RexTextField(
                  outerTitle: StringAssets.businessNameTitle,
                  showOuterTile: true,
                  controller: businessInfoModel.businessNameController,
                  obscureText: false,
                  readOnly: true,
                  backgroundColor: AppColors.grey2,
                ),
                SizedBox(height: 8.ah),
                RexTextField(
                  outerTitle: StringAssets.emailAddressTitle,
                  showOuterTile: true,
                  controller: businessInfoModel.businessEmailController,
                  obscureText: false,
                  validator: (value) => TextfieldValidator.email(value),
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 8.ah),
                RexTextField(
                  outerTitle: StringAssets.phoneNumberTitle,
                  controller: businessInfoModel.businessPhoneController,
                  inputType: TextInputType.phone,
                  obscureText: false,
                  showOuterTile: true,
                  validator: (value) => TextfieldValidator.phoneNumber(value),
                ),
                SizedBox(height: 8.ah),
                RexTextField(
                  outerTitle: StringAssets.businessRegistrationRequiredTitle,
                  controller: businessInfoModel.businessRegNumberController,
                  inputType: TextInputType.number,
                  obscureText: false,
                  readOnly: true,
                  showOuterTile: true,
                  validator: (value) => TextfieldValidator.phoneNumber(value),
                ),
                SizedBox(height: 8.ah),
                RexCustomDropdownWidget(
                  title: StringAssets.businessTypeRequiredTitle,
                  selectedStatus:
                      ref.watch(businessInfoProvider).selectedBusinessType,
                  dropdownDataList:
                      ref.watch(businessInfoProvider).businessTypeList,
                  onChanged: (item) {
                    ref
                        .read(businessInfoProvider.notifier)
                        .setSelectedBusinessType(item);
                  },
                ),
                SizedBox(height: 8.ah),
                RexTextField(
                  outerTitle: StringAssets.businessAddressRequiredTitle,
                  controller: businessInfoModel.businessAddressController,
                  inputType: TextInputType.streetAddress,
                  obscureText: false,
                  showOuterTile: true,
                  validator: (value) => TextfieldValidator.input(value),
                ),
                SizedBox(height: 10.ah),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.aw),
                  child: Row(
                    children: [
                      const Flexible(flex: 1, child: BusinessStateDropdown()),
                      SizedBox(width: 19.aw),
                      const Flexible(flex: 1, child: BusinessLgaDropdown()),
                    ],
                  ),
                ),
                SizedBox(height: 10.ah),
                RexTextField(
                  outerTitle: StringAssets.businessNoOfYearsAtLocation,
                  controller:
                      businessInfoModel.businessYearsInLocationController,
                  obscureText: false,
                  showOuterTile: true,
                  inputType: TextInputType.number,
                  validator: (value) => TextfieldValidator.integer(value),
                ),
                SizedBox(height: 8.ah),
                RexCustomDropdownWidget(
                  title: StringAssets.industry,
                  selectedStatus:
                      ref.watch(businessInfoProvider).selectedBusinessSector,
                  dropdownDataList:
                      ref.watch(businessInfoProvider).industryList,
                  onChanged: (item) {
                    ref
                        .read(businessInfoProvider.notifier)
                        .setSelectedBusinessSector(item);
                  },
                ),
                const SizedBox(height: 22.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: RexElevatedButton(
                    onPressed: () {
                      ref
                          .watch(businessInfoProvider.notifier)
                          .onValidateInput(context);
                    },
                    buttonTitle: StringAssets.saveText,
                    backgroundColor: null,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Center(
              child: Text(
            StringAssets.businessInfoScreenError,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
