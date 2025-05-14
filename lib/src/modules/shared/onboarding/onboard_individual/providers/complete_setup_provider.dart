import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/model/complete_setup_screen_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/provider/set_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final completeSetupProvider =
    NotifierProvider<CompleteSetupNotifier, CompleteSetupScreenState>(
  () => CompleteSetupNotifier(),
);

class CompleteSetupNotifier extends Notifier<CompleteSetupScreenState> {
  @override
  CompleteSetupScreenState build() {
    return CompleteSetupScreenState(
      addressController: TextEditingController(),
      gender: '',
      customerType: 'individual',
      referralCodeController: TextEditingController(text: ''),
      language: 'en',
      state: '',
      lga: '',
      stateLgaResponse: null,
    );
  }

  void initialize() async {
    final json = await _getStatesAndLocals();
    state = state.copyWith(
      stateLgaResponse: stateCapitalResponseFromJson(json),
    );
  }

  Future<dynamic> _getStatesAndLocals() async {
    final statesAndLocals = await rootBundle.loadString(JsonAsset.statesLga);

    return jsonDecode(statesAndLocals);
  }

  void onGenderDropdownChange(String? value) {
    state = state.copyWith(gender: value!);
  }

  void updateSelectedState(String? value) =>
      state = state.copyWith(state: value);

  void updateSelectedCity(String? value) => state = state.copyWith(lga: value);

  void validate(BuildContext context) {
    if (state.addressController.text.isNotBlank &&
        state.state.isNotBlank &&
        state.lga.isNotBlank &&
        state.gender.isNotBlank) {
      completeSetup(context);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
  }

  void completeSetup(BuildContext context) async {
    final username = ref.watch(usernameProvider);
    final onboardingId = ref.watch(userOnboardingIdProvider);
    final incomeRange = ref.watch(userIncomeRangeProvider);
    final employment = ref.watch(userEmploymentCategoryProvider);
    final ninNumber = ref.watch(userNINProvider);
    //
    final addressDto = AddressDto(
      houseNumber: '',
      street: state.addressController.text,
      area: '',
      state: state.state,
      city: '',
      lga: state.lga,
      country: 'Nigeria',
      longitude: 0,
      latitude: 0,
    );
    //
    const businessDetailDto = BusinessDetailDto(
      businessType: 'businessType',
      registrationNumber: 'registrationNumber',
      businessRegistered: 'businessRegistered',
      businessRegistrationLink: 'businessRegistrationLink',
      businessEmail: 'businessEmail',
      businessAddress: 'businessAddress',
      taxNumber: 'taxNumber',
      mobileNumber: 'mobileNumber',
      businessName: 'businessName',
      yearsInBusiness: 1,
      businessSector: 'businessSector',
      businessLogo: 'businessLogo',
      directorInfoList: [],
    );
    //
    final request = CompleteOnboardRequest(
      onboardingId: onboardingId,
      addressDto: addressDto,
      username: username,
      gender: state.gender,
      customerType: state.customerType,
      referralCode: state.referralCodeController.text.isEmpty
          ? 'no-code'
          : state.referralCodeController.text,
      language: state.language,
      documents: const [],
      businessDetailDto: businessDetailDto,
      annualIncomeRange: incomeRange,
      employmentCategory: employment,
      nationalId: ninNumber,
    );
    state = state.copyWith(isLoading: true);
    try {
      final apiResponse = await RexApi.instance.completeOnboard(
        request: request,
      );
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: StringAssets.accountCreatedTitle(
            apiResponse.accountNumber ?? 'n/a',
          ),
          onPressed: () {
            ref.read(setTransactionPinProvider.notifier).toggleFromSignUp(true);
            context.push(Routes.setTransactionPin);
          },
        );
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }
}
