import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class SavingsDashboardTabBar extends StatelessWidget {
  const SavingsDashboardTabBar({
    super.key,
    required TabController tabController,
    required List<String> tabs,
  })  : _tabController = tabController,
        _tabs = tabs;

  final TabController _tabController;
  final List<String> _tabs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        labelColor: AppColors.rexPurpleDark,
        unselectedLabelColor: Colors.grey,
        controller: _tabController,
        tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}
