import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class DashboardBottomNavBar extends StatefulWidget {
  const DashboardBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int)? onTap;

  @override
  State<DashboardBottomNavBar> createState() => _DashboardBottomNavBarState();
}

class _DashboardBottomNavBarState extends State<DashboardBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.rexPurpleLight,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(AssetPath.tabHomeIcon),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.tabMoreIcon,
            color: AppColors.rexPurpleLight,
          ),
          label: 'More',
        ),
      ],
    );
  }
}
