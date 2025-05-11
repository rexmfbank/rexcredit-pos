import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/business/more/profile/business_directors/providers/add_business_director_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/add_director_form_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final addDirectorStateProvider = NotifierProvider.autoDispose<
    AddDirectorStateNotifier, AddDirectorFormState>(
  () => AddDirectorStateNotifier(),
);

class AddDirectorStateNotifier
    extends AutoDisposeNotifier<AddDirectorFormState> {
  @override
  AddDirectorFormState build() {
    return AddDirectorFormState(
      firstNameController: TextEditingController(),
      middleNameController: TextEditingController(),
      lastNameController: TextEditingController(),
      emailController: TextEditingController(),
      mobileNoController: TextEditingController(),
      sharesController: TextEditingController(),
      bvnController: TextEditingController(),
      addressController: TextEditingController(),
      dobController: TextEditingController(),
      dateOfBirth: null,
      gender: '',
      formKey: GlobalKey<FormState>(),
    );
  }

  void onDateSelectionChange(DateTime? value) {
    state = state.copyWith(dateOfBirth: value!);
  }

  void onGenderDropdownChange(String? value) {
    state = state.copyWith(gender: value!);
  }

  bool validate() {
    if (state.formKey.currentState!.validate() &&
        state.firstNameController.text.isNotBlank &&
        state.lastNameController.text.isNotBlank &&
        state.emailController.text.isNotBlank &&
        state.mobileNoController.text.isNotBlank &&
        state.gender.isNotBlank &&
        state.bvnController.text.isNotBlank &&
        state.sharesController.text.isNotBlank &&
        state.dateOfBirth != null) {
      return true;
    }
    return false;
  }

  void addBusinessDirector(BuildContext context) {
    if (state.formKey.currentState!.validate()) {
      AddDirectorsRequest directorForm = AddDirectorsRequest(
        businessCode: ref.watch(businessCodeProvider),
        directors: [
          AddDirectorsRequestData(
            customerId: "",
            firstname: state.firstNameController.text,
            middlename: state.middleNameController.text.isBlank
                ? ""
                : state.middleNameController.text,
            lastname: state.lastNameController.text,
            businessCode: ref.watch(businessCodeProvider),
            email: state.emailController.text,
            mobileNo: state.mobileNoController.text,
            gender: state.gender,
            bvn: state.bvnController.text,
            sharePercent: state.sharesController.text,
            dateOfBirth: state.dateOfBirth.toString(),
            photoLink: '',
          )
        ],
      );
      ref
          .read(addBusinessDirectorsProvider.notifier)
          .addBusinessDirectors(request: directorForm);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
  }
}
