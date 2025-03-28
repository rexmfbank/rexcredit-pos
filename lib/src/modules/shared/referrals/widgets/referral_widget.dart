import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/referrals/providers/fetch_referral_provider.dart';
import 'package:rex_app/src/modules/shared/referrals/widgets/referral_widget_helper.dart';

class ReferralWidget extends ConsumerWidget {
  const ReferralWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referralApi = ref.watch(fetchReferralProvider);
    return referralApi.when(
      data: (userReferralData) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ReferralEarningCard(
              earning: "\u20A6${userReferralData?.totalEarning}",
            ),
            const ReferralCodeCard(),
            ReferralListCard(
              referralList: userReferralData?.referralResponses ?? [],
            ),
          ],
        );
      },
      error: (error, stackTrace) => const ReferralError(),
      loading: () => const ReferralLoading(),
    );
  }
}

class ReferralLoading extends StatelessWidget {
  const ReferralLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text('Sorry, we had an error getting referral data'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReferralError extends StatelessWidget {
  const ReferralError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10.0),
                Text('Loading referrals'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
