import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/more/profile/models/deactivate_account_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final deactivateAccountProvider = AutoDisposeNotifierProvider<
    DeactivateAccountNotifer, DeactivateAccountState>(
  () => DeactivateAccountNotifer(),
);

class DeactivateAccountNotifer
    extends AutoDisposeNotifier<DeactivateAccountState> {
  @override
  DeactivateAccountState build() {
    return const DeactivateAccountState(
      isLoading: false,
      message: '',
      isSuccess: null,
    );
  }

  Future<void> deactivate(BuildContext context) async {
    final authToken = ref.watch(appAuthTokenProvider);
    state = state.copyWith(isLoading: true);
    try {
      final res = await RexApi.instance.deactivateAccount(
        authToken: authToken ?? '',
      );
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        message: res.responseMessage,
      );
      if (context.mounted) {
        context.go(Routes.login);
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        message: error.toString(),
      );
    }
  }
}
