import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SpendTabBar extends StatelessWidget {
  const SpendTabBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.aw),
      decoration: BoxDecoration(
        color: const Color(0xffEBEFF8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBar(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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
          tabs: const [
            Tab(text: StringAssets.rexTransfer),
            Tab(text: StringAssets.billPayments),
          ],
        ),
      ),
    );
  }
}
