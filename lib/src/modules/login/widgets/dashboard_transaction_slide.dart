import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/login/widgets/recent_transaction_item.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class DashboardTransactionSlide extends HookConsumerWidget {
  const DashboardTransactionSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTransact = ref.watch(userRecentTransactionProvider);
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RecentTransactionText(),
          Flexible(
            fit: FlexFit.loose,
            child: recentTransact.when(
              data: (TData tData) {
                if (tData.transactions == null) {
                  return const TransText(text: Strings.recentTransactionError);
                }
                if (tData.transactions!.data.isEmpty) {
                  return const TransText(text: Strings.noTransactions);
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tData.transactions!.data.length,
                  itemBuilder: (context, index) {
                    return RecentTransactionItem(
                      transData: tData.transactions!.data[index],
                      canTap: true,
                    );
                  },
                );
              },
              error:
                  (error, stackTrace) =>
                      const TransText(text: Strings.recentTransactionError),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}

class TransText extends StatelessWidget {
  const TransText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.center,
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}

class RecentTransactionText extends ConsumerWidget {
  const RecentTransactionText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            Strings.recentTransaction,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.rexPurpleDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.push("${Routes.dashboardHome}/${Routes.allTransactions}");
            },
            child: const Text(
              Strings.seeAll,
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
