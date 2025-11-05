import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/disputes/widgets/fetch_dispute_screen_body.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualDisputesScreen extends ConsumerWidget {
  const IndividualDisputesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.symmetric(horizontal: 13.aw),
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: Strings.disputesTitle,
        subtitle: Strings.disputeListSubtitle,
      ),
      body: const FetchDisputeScreenBody(),
    );
  }
}
