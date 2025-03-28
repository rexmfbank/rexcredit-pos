// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/more/state/request_pos_screen_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final requestPOSProvider =
    NotifierProvider<RequestPOSNotifier, RequestPOSScreenState>(
        () => RequestPOSNotifier());

class RequestPOSNotifier extends Notifier<RequestPOSScreenState>
    with LocatorMix {
  @override
  RequestPOSScreenState build() {
    return RequestPOSScreenState.initial();
  }

  void setBVN(String bvn) {
    state = state.copyWith(bvn: bvn);
  }

  set setSelectedEmail(String email) {
    state = state.copyWith(selectedEmail: email);
  }

  void validatePosRequestDetails(BuildContext context) {
    setBVN(ref.watch(userBVNProvider));
    if (state.contactPersonController.text.isBlank) {
      state = state.copyWith(error: StringAssets.contactPersonCannotBeBlank);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.lineOfBusinessController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidLineOfBusinessInput);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.emailAddressController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidEmailInput);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.phoneNumberController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidPhoneNo);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.bvnController.text.isBlank && state.bvn.isBlank) {
      state = state.copyWith(error: StringAssets.invalidBvn);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.ninController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidNin);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.physicalAddressController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidPhysicalAddress);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.formKey.currentState!.validate()) {
      makePOSRequest(context);
    }
  }

  void updateError() {
    state = state.copyWith(error: '');
  }

  Future<void> makePOSRequest(
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(userAuthTokenProvider) ?? '';
    try {
      var posRequest = RequestPOSRequest(
          customerType:
              ref.read(userIsIndividualProvider) ? "individual" : 'business',
          utility: StringAssets.emptyString,
          contactPerson: state.contactPersonController.text,
          username: ref.read(usernameProvider),
          entityCode: ref.read(userEntityCodeProvider),
          phoneNumber: state.phoneNumberController.text,
          emailAddress: state.emailAddressController.text,
          businessCode: ref.read(userIsIndividualProvider)
              ? null
              : ref.read(businessCodeProvider),
          cacDocument: StringAssets.emptyString,
          bvn: state.bvnController.text,
          nin: state.ninController.text,
          mobileNumber: state.phoneNumberController.text,
          lineOfBusiness: state.lineOfBusinessController.text,
          accountName: state.settlementAccountNameController.text,
          accountNumber: state.settlementAccountNumberController.text,
          bankName: state.settlementBankNameController.text,
          address: state.physicalAddressController.text);

      var apiResponse = await RexApi.instance.requestPOS(
        authToken: authToken,
        request: posRequest,
      );
      state = state.copyWith(
          isLoading: false, requestPosResponse: apiResponse.data);
      showModalActionSuccess(
          context: context,
          subtitle: StringAssets.requestPosSuccess,
          title: StringAssets.requestSubmitted,
          onPressed: () {
            context.pop();
            context.pop();
          });
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void validateBusinessPosRequestDetails(BuildContext context) {
    if (state.contactPersonController.text.isBlank) {
      state = state.copyWith(error: StringAssets.contactPersonCannotBeBlank);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.lineOfBusinessController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidLineOfBusinessInput);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.physicalAddressController.text.isBlank) {
      state = state.copyWith(error: StringAssets.invalidPhysicalAddress);
      showModalActionError(context: context, errorText: state.error!);
      return;
    }

    if (state.formKey.currentState!.validate()) {
      makePOSRequest(context);
    }
  }
}
