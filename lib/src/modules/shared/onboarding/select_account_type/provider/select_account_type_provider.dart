import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_account_type/model/account_type_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_account_type/model/select_account_type_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final selectAccountTypeProvider =
    NotifierProvider<SelectAccountTypeNotifier, SelectAccountTypeState>(
  () => SelectAccountTypeNotifier(),
);

class SelectAccountTypeNotifier extends Notifier<SelectAccountTypeState> {
  @override
  SelectAccountTypeState build() {
    return const SelectAccountTypeState(accountType: null);
  }

  void setAccountType(AccountType value) {
    ref.read(userAccountTypeProvider.notifier).state = value.title;
    state = state.copyWith(accountType: value);
  }

  void validateSelection(BuildContext context) {
    final userAccountType = ref.watch(userAccountTypeProvider);
    if (state.accountType == null) {
      showModalActionError(
        context: context,
        errorText: StringAssets.validateSelectAccountTypeError,
      );
    } else if (state.accountType != null &&
        state.accountType!.isSelected == false) {
      showModalActionError(
        context: context,
        errorText: StringAssets.validateSelectAccountTypeError,
      );
    } else {
      if (userAccountType == AccountTypeEnum.INDIVIDUAL.title) {
        context.go(Routes.completeSetup);
      } else {
        context.go(Routes.businessBio);
      }
    }
  }
}
