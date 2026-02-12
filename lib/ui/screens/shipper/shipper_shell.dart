import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../router/routes.dart';
import '../../widgets/animated_bottom_nav.dart';

class ShipperShell extends StatelessWidget {
  final Widget child;
  const ShipperShell({super.key, required this.child});

  int _calcIndex(String location) {
    if (location.startsWith(Routes.shipperOrders)) return 1;
    if (location.startsWith(Routes.shipperNotifications)) return 2;
    if (location.startsWith(Routes.shipperProfile)) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _calcIndex(location);
    return PopScope(
      canPop: index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          context.go(Routes.shipperHome);
        }
      },
      child: Scaffold(
        body: child,
        extendBody: true,
        bottomNavigationBar: AnimatedBottomNav(
          items: const [
            NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
            NavItem(icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long_rounded, label: 'Orders'),
            NavItem(icon: Icons.notifications_outlined, activeIcon: Icons.notifications_rounded, label: 'Alerts'),
            NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
          ],
          currentIndex: index,
          onTap: (i) {
            final route = [Routes.shipperHome, Routes.shipperOrders, Routes.shipperNotifications, Routes.shipperProfile][i];
            context.go(route);
          },
        ),
      ),
    );
  }
}
