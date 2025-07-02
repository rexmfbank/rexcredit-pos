import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/referrals/widgets/referral_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessReferralScreen extends HookConsumerWidget {
  const BusinessReferralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.symmetric(horizontal: 10.aw),
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.referralTitle,
        subtitle: StringAssets.referralSubtitle,
      ),
      body: const ReferralWidget(),
    );
  }
}

class ReferralLinkWidget extends StatelessWidget {
  const ReferralLinkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your referral code'),
            const SizedBox(height: 10),
            const Text(
              'Ale098',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'https://app.Rexdigital.com/Ale129',
              style: TextStyle(color: Colors.lightBlue),
            ),
            Row(
              children: [
                Expanded(
                  child: RexFlatButton(
                      onPressed: () {},
                      buttonTitle: 'Copy Link',
                      textColor: AppColors.rexPurpleDark,
                      backgroundColor: AppColors.lightGrey),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: RexFlatButton(
                      onPressed: () {},
                      buttonTitle: 'Share Link',
                      backgroundColor: null),
                )
              ],
            )
          ],
        ));
  }
}

class ReferralEarningsWidget extends StatelessWidget {
  const ReferralEarningsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Row(children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Referral Earnings',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Text(
              'N21,000',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Image.asset('assets/png/commission_icon.png'),
        )
      ]),
    );
  }
}
