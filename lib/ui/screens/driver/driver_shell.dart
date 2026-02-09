import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../router/routes.dart';
import '../../widgets/animated_bottom_nav.dart';

class DriverShell extends StatelessWidget {
  final Widget child;
  const DriverShell({super.key, required this.child});

  int _calcIndex(String location) {
    if (location.startsWith(Routes.driverHistory)) return 1;
    if (location.startsWith(Routes.driverProfile)) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _calcIndex(location);
    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: AnimatedBottomNav(
        items: const [
          NavItem(icon: Icons.route_outlined, activeIcon: Icons.route_rounded, label: 'Trip'),
          NavItem(icon: Icons.history_outlined, activeIcon: Icons.history_rounded, label: 'History'),
          NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
        ],
        currentIndex: index,
        onTap: (i) {
          final route = [Routes.driverHome, Routes.driverHistory, Routes.driverProfile][i];
          context.go(route);
        },
      ),
    );
  }
}
