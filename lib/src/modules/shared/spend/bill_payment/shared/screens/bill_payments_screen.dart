import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/enums/biller_categories.dart';

import '../../../../../revamp/utils/config/theme/app_colors.dart';

class BillPaymentsScreen extends ConsumerStatefulWidget {
  const BillPaymentsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BillPaymentsScreen();
}

class _BillPaymentsScreen extends ConsumerState<BillPaymentsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(billPaymentProvider.notifier).fetchBillerCategories(context);
      ref.read(billPaymentProvider.notifier).fetchSavedCards(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      child: const BillPaymentsListView(),
    );
  }
}

class BillPaymentsListView extends ConsumerWidget {
  const BillPaymentsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(billPaymentProvider);
    var billerCategories = state.billerCategories ?? [];

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.ah),
          child: RefreshIndicator(
            color: AppColors.rexPurpleLight,
            onRefresh: () async {
              ref
                  .read(billPaymentProvider.notifier)
                  .fetchBillerCategories(context);
              ref.read(billPaymentProvider.notifier).fetchSavedCards(context);
            },
            child: GridView.count(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10.ah,
              crossAxisSpacing: 10.aw,
              children: billerCategories
                  .map(
                    (item) => BillPaymentGridItem(
                      item: item,
                      onTap: () {
                        final category =
                            item.billerCategoryName?.trim().toUpperCase();
                        ref
                            .read(billPaymentProvider.notifier)
                            .onNavigate(context, category?.billerCategories);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ],
    );
  }
}

class BillPaymentGridItem extends StatelessWidget {
  const BillPaymentGridItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  final BillerCategory item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.ar),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.ah,
                child: CachedNetworkImage(imageUrl: item.logoUrl ?? ""),
              ),
              SizedBox(height: 16.ah),
              Text(
                item.billerCategoryName?.toUpperCase() ?? 'N/A',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.rexTint700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
