import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  NavDestination(label: 'Home', icon: Icons.poll_sharp),
  NavDestination(label: 'Purchase', icon: Icons.podcasts),
  NavDestination(label: 'Receipt', icon: Icons.podcasts),
  NavDestination(label: 'Settings', icon: Icons.podcasts),
];
