import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/more/profile/states/update_residential_address_state.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/revamp/utils/locator_mixin.dart';

import '../../../../utils/constants/string_assets.dart';
import '../../../shared/widgets/modal_bottom_sheets/show_modal_action.dart';

final updateResidentialAddressProvider = AutoDisposeNotifierProvider<
  UpdateResidentialAddressNotifier,
  UpdateResidentialAddressScreenState
>(() => UpdateResidentialAddressNotifier());

class UpdateResidentialAddressNotifier
    extends AutoDisposeNotifier<UpdateResidentialAddressScreenState>
    with LocatorMix {
  @override
  UpdateResidentialAddressScreenState build() =>
      UpdateResidentialAddressScreenState.initial();

  void fetchStates() async {
    final json = await _getStates();
    state = state.copyWith(nigeriaStates: stateCapitalResponseFromJson(json));
  }

  Future<dynamic> _getStates() async {
    final statesAndLocals = await rootBundle.loadString(JsonAsset.statesLga);

    return jsonDecode(statesAndLocals);
  }

  set setSelectedState(String selectedState) {
    state = state.copyWith(selectedNigeriaState: selectedState);
  }

  set setSelectedLGA(String selectedLGA) {
    state = state.copyWith(selectedLga: selectedLGA);
  }

  void validateInputAndProceed(BuildContext context) {
    if (state.fileFromDevice == null || state.fileName.isBlank) {
      showModalActionError(
        context: context,
        errorText: StringAssets.uploadValidImage,
      );
      return;
    }
    if (state.houseNumberController.text.isEmpty ||
        state.streetController.text.isEmpty ||
        state.areaController.text.isEmpty) {
      showModalActionError(
        context: context,
        errorText: StringAssets.pleaseFillAllRequiredFields,
      );
      return;
    }
    if (state.selectedNigeriaState.isBlank || state.selectedLga.isBlank) {
      showModalActionError(
        context: context,
        errorText: StringAssets.validationError,
      );
      return;
    }
    updateResidentialAddress(context);
  }

  Future<void> updateResidentialAddress(BuildContext context) async {
    Position? position = await getCurrentPosition(context);
    state = state.copyWith(isLoading: true);
    try {
      UpdateAddressRequest request = UpdateAddressRequest(
        houseNo: state.houseNumberController.text,
        street: state.streetController.text,
        area: state.areaController.text,
        state: state.selectedNigeriaState,
        lga: state.selectedLga,
        city: state.addressController.text,
        country: 'Nigeria',
        latitude: position?.latitude ?? 0.0,
        longitude: position?.latitude ?? 0.0,
      );

      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          enableDrag: false,
          subtitle: StringAssets.updateAddressRequestSentSuccessfully,
          onPressed: () {
            context.pop();
            context.pop();
          },
        );
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }
}
