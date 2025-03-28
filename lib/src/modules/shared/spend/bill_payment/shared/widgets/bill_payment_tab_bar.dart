import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/theme/app_colors.dart';
import '../../../../../../utils/constants/string_assets.dart';

class BillPaymentTabBar extends StatelessWidget {
  const BillPaymentTabBar({
    super.key,
    required this.tabController,
    required this.length,
    this.firstTabText = StringAssets.newPayments,
  });

  final TabController tabController;
  final int length;
  final String? firstTabText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffEBEFF8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBar(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          indicatorWeight: 1.0,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
          labelColor: AppColors.rexPurpleDark,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: [
            Tab(text: firstTabText),
            const Tab(text: StringAssets.beneficiaries),
            if (length == 3)
              const Tab(text: StringAssets.airtimeHistory),
          ],
        ),
      ),
    );
  }
}
