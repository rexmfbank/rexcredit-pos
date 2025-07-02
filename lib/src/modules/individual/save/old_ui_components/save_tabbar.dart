import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class SaveTabBar extends StatelessWidget {
  const SaveTabBar({
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
            controller: _tabController,
            tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
          ),
        ),
      ),
    );
  }
}
