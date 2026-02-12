import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../router/routes.dart';
import '../../widgets/animated_bottom_nav.dart';

class OwnerShell extends StatelessWidget {
  final Widget child;
  const OwnerShell({super.key, required this.child});

  int _calcIndex(String location) {
    if (location.startsWith(Routes.ownerBids)) return 1;
    if (location.startsWith(Routes.ownerFleet)) return 2;
    if (location.startsWith(Routes.ownerEarnings)) return 3;
    if (location.startsWith(Routes.ownerProfile)) return 4;
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
          context.go(Routes.ownerHome);
        }
      },
      child: Scaffold(
        body: child,
        extendBody: true,
        bottomNavigationBar: AnimatedBottomNav(
          items: const [
            NavItem(
              icon: Icons.list_alt_outlined,
              activeIcon: Icons.list_alt_rounded,
              label: 'Orders',
            ),
            NavItem(
              icon: Icons.gavel_outlined,
              activeIcon: Icons.gavel_rounded,
              label: 'Bids',
            ),
            NavItem(
              icon: Icons.local_shipping_outlined,
              activeIcon: Icons.local_shipping_rounded,
              label: 'Fleet',
            ),
            NavItem(
              icon: Icons.account_balance_wallet_outlined,
              activeIcon: Icons.account_balance_wallet_rounded,
              label: 'Earnings',
            ),
            NavItem(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profile',
            ),
          ],
          currentIndex: index,
          onTap: (i) {
            final route = [
              Routes.ownerHome,
              Routes.ownerBids,
              Routes.ownerFleet,
              Routes.ownerEarnings,
              Routes.ownerProfile,
            ][i];
            context.go(route);
          },
        ),
      ),
    );
  }
}
