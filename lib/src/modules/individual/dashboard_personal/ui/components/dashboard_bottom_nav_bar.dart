import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
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
            AssetPath.tabSpendIcon,
            color: AppColors.rexPurpleLight,
          ),
          label: 'Bills',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.tabSaveIcon,
            color: AppColors.rexPurpleLight,
          ),
          label: 'Save',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AssetPath.tabBorrowIcon,
            color: AppColors.rexPurpleLight,
          ),
          label: 'Borrow',
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
