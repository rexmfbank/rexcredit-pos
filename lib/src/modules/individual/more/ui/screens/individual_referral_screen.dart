import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/referrals/widgets/referral_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualReferralScreen extends ConsumerWidget {
  const IndividualReferralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.symmetric(horizontal: 10.aw),
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.referralTitle,
        subtitle: StringAssets.referralSubtitle,
        step: null,
      ),
      body: const ReferralWidget(),
    );
  }
}
