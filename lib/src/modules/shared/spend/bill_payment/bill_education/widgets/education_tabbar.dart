import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class EducationTabBar extends StatelessWidget {
  const EducationTabBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
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
              Tab(text: 'New Payments'),
              Tab(text: 'Saved Payments'),
            ],
          ),
        ),
      ),
    );
  }
}
