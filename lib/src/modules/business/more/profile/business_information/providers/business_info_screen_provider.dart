import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/states/business_info_screen_state.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final businessInfoProvider =
    StateNotifierProvider<BusinessInfoNotifier, BusinessInformationScreenState>(
        (ref) => BusinessInfoNotifier(ref));

class BusinessInfoNotifier
    extends StateNotifier<BusinessInformationScreenState> {
  BusinessInfoNotifier(this.ref)
      : super(BusinessInformationScreenState.initial());

  final StateNotifierProviderRef<BusinessInfoNotifier,
      BusinessInformationScreenState> ref;

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
    state = state.copyWith(selectedBusinessType: value!);
  }

  void onBusinessIndustryDropdownChange(String? value) {
    state = state.copyWith(selectedBusinessSector: value!);
  }

  void setSelectedBusinessType(String? value) =>
      state = state.copyWith(selectedBusinessType: value);

  void setSelectedBusinessSector(String? value) =>
      state = state.copyWith(selectedBusinessSector: value);

  void updateSelectedState(String? value) =>
      state = state.copyWith(businessState: value);

  void updateSelectedCity(String? value) =>
      state = state.copyWith(businessLga: value);

  void setYearsInLocation(String value) =>
      state = state.copyWith(yearsInLocation: value);

  void onValidateInput(BuildContext context) {
    if (state.businessAddressController.text.isBlank) {
      state.copyWith(error: StringAssets.enterValidAddress);
    }

    if (state.selectedBusinessType.isBlank ||
        state.selectedBusinessType == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidBusinessType);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.selectedBusinessSector.isBlank ||
        state.selectedBusinessSector == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidIndustry);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.businessState.isBlank ||
        state.businessState == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidState);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.businessLga.isBlank ||
        state.businessLga == StringAssets.selectAnOption) {
      state = state.copyWith(error: StringAssets.selectValidLga);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    performBusinessInfoUpdate(context);

    // if (state.formKey.currentState!.validate()) {
    //   performBusinessInfoUpdate(context);
    //   return;
    // }
    // showModalActionError(
    //   context: context,
    //   title: StringAssets.validationError,
    //   errorText: StringAssets.pleaseFillAllFields,
    // );
  }

  Future<void> performBusinessInfoUpdate(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      UpdateBusinessRequest requestForm = UpdateBusinessRequest(
        businessCode: ref.watch(businessCodeProvider),
        logo: state.businessLogo,
        name: state.businessNameController.text,
        type: state.selectedBusinessType ?? '',
        sector: state.selectedBusinessSector ?? '',
        address: state.businessAddressController.text,
        emailAddress: state.businessEmailController.text,
        mobileNo: state.businessPhoneController.text,
        state: state.businessState ?? '',
        lga: state.businessLga ?? '',
        country: "Nigeria",
        startYear: getYear(state.businessYearsInLocationController.text),
        startMonth: DateTime.now().month,
      );

      var apiResponse = await RexApi.instance.updateBusiness(
        authToken: authToken,
        request: requestForm,
      );

      state = state.copyWith(isLoading: false);
      showModalActionSuccess(
        context: context,
        title: StringAssets.congratsTitle,
        subtitle: StringAssets.businessProfileUpdatedSuccess,
        onPressed: () {
          context.pop();
        },
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  int getYear(String yearsAgo) {
    try {
      final now = DateTime.now();
      final targetYear = now.year - int.parse(yearsAgo);
      return targetYear;
    } catch (error) {
      debugPrint("getYear Error");
      return DateTime.now().year;
    }
  }

  String yearsAgo(String? year) {
    if (year == null || year.trim().isEmpty) {
      return '';
    }

    final currentYear = DateTime.now().year;
    final targetYear = int.tryParse(year);

    if (targetYear == null) {
      return '';
    }

    final yearsAgo = currentYear - targetYear;
    return yearsAgo.toString();
  }
}
