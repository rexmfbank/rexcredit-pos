import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/more/profile/models/next_of_kin_view_model.dart';
import 'package:rex_app/src/modules/more/profile/providers/add_next_of_kin_api_provider.dart';
import 'package:rex_app/src/modules/more/provider/more_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

///Welcome page notifier provider
final nextOfKinNotifier =
    NotifierProvider<NextOfKinNotifier, NextOfKinViewModel>(
      () => NextOfKinNotifier(),
    );

class NextOfKinNotifier extends Notifier<NextOfKinViewModel> {
  @override
  NextOfKinViewModel build() => NextOfKinViewModel(
    firstNameController: TextEditingController(),
    lastNameController: TextEditingController(),
    addressController: TextEditingController(),
    phoneController: TextEditingController(),
    dateOfBirth: null,
    formKey: GlobalKey<FormState>(),
    kinRelationship: null,
  );

  void updateRelationship(String value) =>
      state = state.copyWith(kinRelationship: value);

  void onDateSelectionChange(DateTime? value) {
    state = state.copyWith(dateOfBirth: value!);
  }

  void performNextOfKinUpdate(BuildContext context) {
    if (state.formKey.currentState!.validate() && state.dateOfBirth != null) {
      final primaryAccountNo = ref.watch(userNubanProvider);
      AddNextOfKinRequest nokForm = AddNextOfKinRequest(
        firstName: state.firstNameController.text,
        lastName: state.lastNameController.text,
        relationship: ref.watch(nextOfKinRelationshipProvider).name,
        emailAddress: state.addressController.text,
        mobileNo: state.phoneController.text,
        dob: state.dateOfBirth!.dateYYYYMMDD(),
        accountNo: primaryAccountNo,
      );
      ref.read(addNextOfKinApiProvider.notifier).addNextOfKin(request: nokForm);
      return;
    }
    showModalActionError(
      context: context,
      title: Strings.validationError,
      errorText: Strings.pleaseFillAllFields,
    );
  }
}
