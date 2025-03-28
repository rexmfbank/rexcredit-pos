import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/business/more/profile/models/business_representative_view_model.dart';
import 'package:rex_app/src/modules/business/more/profile/providers/create_representative_api_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final businessRepresentativeScreenProvider = NotifierProvider.autoDispose<
    BusinessRepresentativeNotifier,
    BusinessRepresentativeViewModel>(() => BusinessRepresentativeNotifier());

class BusinessRepresentativeNotifier
    extends AutoDisposeNotifier<BusinessRepresentativeViewModel> {
  @override
  BusinessRepresentativeViewModel build() => BusinessRepresentativeViewModel(
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        middleNameController: TextEditingController(),
        emailController: TextEditingController(),
        phoneController: TextEditingController(),
        dobController: TextEditingController(),
        dateOfBirth: null,
        formKey: GlobalKey<FormState>(),
      );

  void onDateSelectionChange(DateTime? value) {
    state = state.copyWith(dateOfBirth: value!);
  }

  bool validate(){
    if(state.formKey.currentState!.validate() && state.firstNameController.text.isNotBlank && state.lastNameController.text.isNotBlank && state.middleNameController.text.isNotBlank && state.emailController.text.isNotBlank && state.dateOfBirth.toString().isNotBlank){
      return true;
    }
    return false;
  }

  void createBusinessRepresentative(BuildContext context) {
    if (validate()) {
      CreateRepresentativeRequest representativeForm =
          CreateRepresentativeRequest(
        firstName: state.firstNameController.text,
        lastName: state.lastNameController.text,
        middleName: state.middleNameController.text,
        phoneNumber: "",
        email: state.emailController.text,
        dateOfBirth: state.dateOfBirth!.dateDDMMYYYY(),
      );
      ref
          .read(createRepresentativeApiProvider.notifier)
          .createBusinessRepresentative(request: representativeForm);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
  }
}
