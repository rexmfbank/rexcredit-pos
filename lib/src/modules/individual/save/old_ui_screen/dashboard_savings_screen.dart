import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/dashboard_savings_appbar.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';

class DashboardSavingsScreen extends HookConsumerWidget {
  const DashboardSavingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    final logger = ref.watch(loggerProvider);

    return Scaffold(
      appBar: const DashboardSavingsAppBar(),
      body: Column(),
      // body: savingsList.when(
      //   data: (data) {
      //     if (data.isEmpty) {
      //       return const EmptyStateSavingsScreen();
      //     } else {
      //       return const NonEmptyStateSavingsScreen();
      //     }
      //   },
      //   error: (obj, stack) => const ErrorStateSavingsScreen(),
      //   loading: () => const Center(
      //     child: CircularProgressIndicator(
      //       color: AppColors.rexPurpleDark,
      //     ),
      //   ),
      // ),
    );
  }
}
