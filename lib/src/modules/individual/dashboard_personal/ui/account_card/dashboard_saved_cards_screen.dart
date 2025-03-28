import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/dashboard_topup_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/dashboard_saved_card_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardSavedCardsScreen extends ConsumerStatefulWidget {
  const DashboardSavedCardsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardSavedCardsScreenState();
}

class _DashboardSavedCardsScreenState
    extends ConsumerState<DashboardSavedCardsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardTopUpProvider.notifier).toggleCardSelected(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(dashboardTopUpProvider).isLoading,
      padding: EdgeInsets.zero,
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.savedCardTitle,
        subtitle: StringAssets.savedCardSubtitle,
        onBackButtonPressed: () {
          ref.watch(dashboardTopUpProvider.notifier).toggleCardSelected(false);
          context.pop();
        },
      ),
      body: const DashboardSavedCardScreenBody(),
    );
  }
}
