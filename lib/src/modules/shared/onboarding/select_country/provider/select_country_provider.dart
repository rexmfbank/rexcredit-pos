// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final selectCountryProvider =
    NotifierProvider<SelectCountryNotifier, SelectCountryState>(
  () => SelectCountryNotifier(),
);

class SelectCountryNotifier extends Notifier<SelectCountryState>
    with LocatorMix {
  @override
  SelectCountryState build() {
    return const SelectCountryState(
      appCountry: null,
    );
  }

  void setCountry(AppCountry appCountry) {
    state = state.copyWith(appCountry: appCountry);
  }

  void validateSelection(BuildContext context) async {
    if (state.appCountry == null) {
      showModalActionError(
        context: context,
        errorText: StringAssets.validateSelectCountryError,
      );
    } else if (state.appCountry != null &&
        state.appCountry!.isSelected == false) {
      showModalActionError(
        context: context,
        errorText: StringAssets.validateSelectCountryError,
      );
    } else {
      context.go(RouteName.welcome);
    }
  }
}

class SelectCountryState extends Equatable {
  final AppCountry? appCountry;

  const SelectCountryState({
    required this.appCountry,
  });

  SelectCountryState copyWith({
    AppCountry? appCountry,
  }) {
    return SelectCountryState(
      appCountry: appCountry ?? this.appCountry,
    );
  }

  @override
  List<Object?> get props => [appCountry];
}
