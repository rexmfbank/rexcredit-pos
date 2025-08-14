import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/more/profile/models/personal_info_model.dart';
import 'package:rex_app/src/modules/more/profile/providers/update_user_personal_info_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final personalInfoScreenNotifier =
    NotifierProvider<PersonalInfoNotifier, PersonalInfoViewModel>(
        () => PersonalInfoNotifier());

class PersonalInfoNotifier extends Notifier<PersonalInfoViewModel> {
  @override
  PersonalInfoViewModel build() => PersonalInfoViewModel(
        middleNameController: TextEditingController(),
        formKey: GlobalKey<FormState>(),
      );

  void performPersonalInfoUpdate(BuildContext context) {
    final firstName = ref.watch(userFirstNameProvider);
    final fullname = ref.watch(userFullNameProvider);
    final userName = ref.watch(usernameProvider);
    if (state.formKey.currentState!.validate()) {
      UpdateUserRequest nokForm = UpdateUserRequest(
        id: 111,
        firstName: firstName,
        middlename: state.middleNameController.text,
        lastName: fullname.split(" ").last,
        userName: userName,
        entityCode: 'RMB',
        photoLink: '',
        email: '',
      );
      ref
          .read(updatePersonalInfoProvider.notifier)
          .updateUserPersonalInfo(context: context, request: nokForm);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
  }
}
