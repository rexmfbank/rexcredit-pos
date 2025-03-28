import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

class ReferralListCard extends ConsumerWidget {
  const ReferralListCard({
    super.key,
    required this.referralList,
  });

  final List<ReferralResponse> referralList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your referral list',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            referralList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'You have no referrals.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: referralList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          referralList[index].referredUsername ?? 'N/A',
                        ),
                        subtitle: Text(referralList[index].status ?? 'N/A'),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class ReferralEarningCard extends ConsumerWidget {
  const ReferralEarningCard({
    super.key,
    required this.earning,
  });

  final String earning;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Referral Earnings',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                earning,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset('assets/png/commission_icon.png'),
          )
        ],
      ),
    );
  }
}

class ReferralCodeCard extends ConsumerWidget {
  const ReferralCodeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refCode = ref.watch(userReferralCodeProvider);

    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your referral code',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  refCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Clipboard.setData(ClipboardData(text: refCode));
                  },
                  icon: const Icon(Icons.content_copy),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
