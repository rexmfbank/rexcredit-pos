import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

class NavScreen extends ConsumerStatefulWidget {
  const NavScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavScreenState();
}

class _NavScreenState extends ConsumerState<NavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.rexWhite,
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: widget.navigationShell.goBranch,
        destinations:
            navDestinations.map((destination) {
              return NavigationDestination(
                icon: Icon(destination.icon),
                label: destination.label,
              );
            }).toList(),
      ),
    );
  }
}

class NavDestination {
  final String label;
  final IconData icon;

  const NavDestination({required this.label, required this.icon});
}

final navDestinations = [
  NavDestination(label: 'Home', icon: Icons.home),
  NavDestination(label: 'Settings', icon: Icons.settings),
];
