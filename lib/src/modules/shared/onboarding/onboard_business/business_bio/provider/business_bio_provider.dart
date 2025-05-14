// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/model/business_bio_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_logo_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/provider/onboard_biz_info_provider.dart';

import 'package:rex_app/src/modules/shared/onboarding/select_account_type/model/account_type_enum.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final businessBioProvider =
    NotifierProvider<BusinessBioNotifier, BusinessBioState>(
  () => BusinessBioNotifier(),
);

class BusinessBioNotifier extends Notifier<BusinessBioState> {
  OnboardBusinessInfoResponse? bizInfo;

  @override
  BusinessBioState build() {
    bizInfo = ref.watch(onboardBizInfoProvider).asData?.value;
    return BusinessBioState(
      businessNameController:
          TextEditingController(text: bizInfo?.data.businessName ?? ''),
      businessEmailController:
          TextEditingController(text: bizInfo?.data.businessEmail ?? ''),
      businessRegNumberController:
          TextEditingController(text: bizInfo?.data.businessRegNumber ?? ''),
      businessTaxController:
          TextEditingController(text: bizInfo?.data.businessTaxId ?? ''),
      businessAddressController:
          TextEditingController(text: bizInfo?.data.businessAddress ?? ''),
      businessPhoneController:
          TextEditingController(text: bizInfo?.data.businessMobileNo ?? ''),
      businessYearsController:
          TextEditingController(text: "${bizInfo?.data.yearsInBusiness ?? ''}"),
      businessType: bizInfo?.data.businessType ?? '',
      businessRegistered: '',
      businessRegistrationLink: '',
      businessSector: bizInfo?.data.businessType ?? '',
      businessLogo: '',
      businessState: '',
      businessLGA: '',
      stateLgaResponse: null,
    );
  }

  void initialize() async {
    final json = await getStatesAndLocals();
    state =
        state.copyWith(stateLgaResponse: stateCapitalResponseFromJson(json));
  }

  Future<dynamic> getStatesAndLocals() async {
    final statesAndLocals = await rootBundle.loadString(JsonAsset.statesLga);

    return jsonDecode(statesAndLocals);
  }

  void onBusinessTypeDropdownChange(String? value) {
    state = state.copyWith(businessType: value!);
  }

  void onBusinessIndustryDropdownChange(String? value) {
    state = state.copyWith(businessSector: value!);
  }

  void setBusinessRegistered(String value) =>
      state = state.copyWith(businessRegistered: value);

  void setBusinessRegistrationLink(String value) =>
      state = state.copyWith(businessRegistrationLink: value);

  void updateSelectedState(String? value) =>
      state = state.copyWith(businessState: value);

  void updateSelectedLGA(String? value) =>
      state = state.copyWith(businessLGA: value);

  void validateInputAndSubmit(BuildContext context) {
    if (state.businessNameController.text.isNotBlank &&
        state.businessEmailController.text.isNotBlank &&
        state.businessRegNumberController.text.isNotBlank &&
        state.businessTaxController.text.isNotBlank &&
        state.businessAddressController.text.isNotBlank &&
        state.businessPhoneController.text.isNotBlank &&
        state.businessYearsController.text.isNotBlank &&
        state.businessSector.isNotBlank &&
        state.businessState.isNotBlank &&
        state.businessLGA.isNotBlank &&
        state.businessSector.isNotBlank) {
      submitBusinessInfo(context);
    } else {
      showModalActionError(
        context: context,
        title: StringAssets.validationError2,
        errorText: StringAssets.pleaseFillAllFields,
      );
    }
  }

  /// "businessType", "username" & "customerType" CANNOT BE EMPTY
  void submitBusinessInfo(BuildContext context) async {
    final businessLogo = ref.watch(businessLogoProvider);
    final username = ref.watch(usernameProvider);
    final onboardingId = ref.watch(userOnboardingIdProvider);
    final accountType = ref.watch(userAccountTypeProvider);
    //
    final request = CompleteOnboardRequest(
      onboardingId: onboardingId,
      addressDto: AddressDto(
        houseNumber: '',
        street: state.businessAddressController.text,
        area: '',
        state: state.businessState,
        city: '',
        lga: state.businessLGA,
        country: '',
        longitude: 0,
        latitude: 0,
      ),
      username: username,
      gender: 'male',
      customerType: 'business',
      referralCode: '',
      language: 'en',
      employmentCategory: '',
      annualIncomeRange: '',
      nationalId: '',
      documents: [],
      businessDetailDto: BusinessDetailDto(
        businessType: accountType,
        registrationNumber: state.businessRegNumberController.text,
        businessRegistered: state.businessRegistered,
        businessRegistrationLink: state.businessRegistrationLink,
        businessEmail: state.businessEmailController.text,
        businessAddress: state.businessAddressController.text,
        taxNumber: state.businessTaxController.text,
        mobileNumber: state.businessPhoneController.text,
        businessName: state.businessNameController.text,
        yearsInBusiness: int.tryParse(state.businessYearsController.text) ?? 0,
        businessSector: state.businessSector,
        businessLogo: businessLogo.documentPath,
        directorInfoList: [],
      ),
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.completeOnboard(request: request);
      LoadingScreen.instance().hide();
      showModalActionSuccess(
        context: context,
        title: StringAssets.businessBio1,
        subtitle: StringAssets.businessBio2,
        onPressed: () {
          if (accountType == AccountTypeEnum.COOPERATIVE.title) {
            context.push(Routes.bizCooperativeDocs);
          } else if (accountType == AccountTypeEnum.LIMITED_LIABILITY.title) {
            context.push(Routes.bizllcDocs);
          } else if (accountType == AccountTypeEnum.PARTNERSHIP.title) {
            context.push(Routes.bizPartnershipDocs);
          } else if (accountType == AccountTypeEnum.SOLE_PROPRIETORSHIP.title) {
            context.push(Routes.bizProprietorDocs);
          }
        },
      );
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  // void validateAndPerformBusinessInfoUpdate(BuildContext context) {
  //   if (ref.read(businessLogoProvider).fileName.isNotBlank &&
  //       ref.read(businessLogoProvider).imageFromDevice.toString().isNotBlank &&
  //       state.businessNameController.text.isNotBlank &&
  //       state.businessEmailController.text.isNotBlank &&
  //       state.businessRegNumberController.text.isNotBlank &&
  //       state.businessAddressController.text.isNotBlank &&
  //       state.businessPhoneController.text.isNotBlank &&
  //       state.businessType.isNotBlank &&
  //       state.businessSector.isNotBlank &&
  //       state.businessState.isNotBlank &&
  //       state.businessCity.isNotBlank) {
  //     ref
  //         .read(businessInfoProvider.notifier)
  //         .performBusinessInfoUpdate(context);
  //     return;
  //   }
  //   showModalActionError(
  //     context: context,
  //     title: StringAssets.validationError,
  //     errorText: StringAssets.pleaseFillAllFields,
  //   );
  // }

  // bool shareCheck({required String initialShare, String? secondaryShare}) {
  //   if ((int.parse(initialShare) + int.parse(secondaryShare ?? '0')) < 70 ||
  //       (int.parse(initialShare) + int.parse(secondaryShare ?? '0')) > 100) {
  //     return false;
  //   }
  //   return true;
  // }
}
