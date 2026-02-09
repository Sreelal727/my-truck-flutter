import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/enums/user_role.dart';
import '../providers/auth_provider.dart';
import '../ui/screens/splash/splash_screen.dart';
import '../ui/screens/auth/onboarding_screen.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/verify_otp_screen.dart';
import '../ui/screens/auth/role_select_screen.dart';
import '../ui/screens/auth/profile_setup_screen.dart';
import '../ui/screens/shipper/shipper_shell.dart';
import '../ui/screens/shipper/shipper_home_screen.dart';
import '../ui/screens/shipper/create_order_screen.dart';
import '../ui/screens/shipper/bidding_screen.dart';
import '../ui/screens/shipper/order_confirmed_screen.dart';
import '../ui/screens/shipper/tracking_screen.dart';
import '../ui/screens/shipper/shipper_orders_screen.dart';
import '../ui/screens/shipper/shipper_notifications_screen.dart';
import '../ui/screens/shipper/shipper_profile_screen.dart';
import '../ui/screens/owner/owner_shell.dart';
import '../ui/screens/owner/owner_home_screen.dart';
import '../ui/screens/owner/order_detail_screen.dart';
import '../ui/screens/owner/place_bid_screen.dart';
import '../ui/screens/owner/owner_bids_screen.dart';
import '../ui/screens/owner/owner_fleet_screen.dart';
import '../ui/screens/owner/owner_earnings_screen.dart';
import '../ui/screens/owner/owner_profile_screen.dart';
import '../ui/screens/driver/driver_shell.dart';
import '../ui/screens/driver/driver_home_screen.dart';
import '../ui/screens/driver/driver_history_screen.dart';
import '../ui/screens/driver/driver_profile_screen.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final path = state.uri.path;
      final status = authState.status;

      // Always allow splash
      if (path == Routes.splash) return null;

      // If not authenticated, redirect to appropriate auth screen
      if (status != AuthStatus.authenticated) {
        if (path.startsWith('/shipper') ||
            path.startsWith('/owner') ||
            path.startsWith('/driver')) {
          return Routes.login;
        }
        return null;
      }

      // If authenticated and on auth pages, redirect to role home
      if (status == AuthStatus.authenticated) {
        if (path == Routes.login ||
            path == Routes.onboarding ||
            path == Routes.verifyOtp ||
            path == Routes.roleSelect ||
            path == Routes.profileSetup) {
          return _homeForRole(authState.user?.role);
        }
      }
      return null;
    },
    routes: [
      // Splash
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const SplashScreen(),
      ),

      // Auth Flow
      GoRoute(
        path: Routes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.verifyOtp,
        builder: (_, __) => const VerifyOtpScreen(),
      ),
      GoRoute(
        path: Routes.roleSelect,
        builder: (_, __) => const RoleSelectScreen(),
      ),
      GoRoute(
        path: Routes.profileSetup,
        builder: (_, __) => const ProfileSetupScreen(),
      ),

      // Shipper Shell
      ShellRoute(
        builder: (_, state, child) => ShipperShell(child: child),
        routes: [
          GoRoute(
            path: Routes.shipperHome,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ShipperHomeScreen(),
            ),
          ),
          GoRoute(
            path: Routes.shipperOrders,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ShipperOrdersScreen(),
            ),
          ),
          GoRoute(
            path: Routes.shipperNotifications,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ShipperNotificationsScreen(),
            ),
          ),
          GoRoute(
            path: Routes.shipperProfile,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: ShipperProfileScreen(),
            ),
          ),
        ],
      ),

      // Shipper detail screens (outside shell)
      GoRoute(
        path: Routes.shipperCreateOrder,
        builder: (_, __) => const CreateOrderScreen(),
      ),
      GoRoute(
        path: Routes.shipperBidding,
        builder: (_, __) => const BiddingScreen(),
      ),
      GoRoute(
        path: Routes.shipperOrderConfirmed,
        builder: (_, __) => const OrderConfirmedScreen(),
      ),
      GoRoute(
        path: Routes.shipperTracking,
        builder: (_, __) => const TrackingScreen(),
      ),

      // Owner Shell
      ShellRoute(
        builder: (_, state, child) => OwnerShell(child: child),
        routes: [
          GoRoute(
            path: Routes.ownerHome,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: OwnerHomeScreen(),
            ),
          ),
          GoRoute(
            path: Routes.ownerBids,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: OwnerBidsScreen(),
            ),
          ),
          GoRoute(
            path: Routes.ownerFleet,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: OwnerFleetScreen(),
            ),
          ),
          GoRoute(
            path: Routes.ownerEarnings,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: OwnerEarningsScreen(),
            ),
          ),
          GoRoute(
            path: Routes.ownerProfile,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: OwnerProfileScreen(),
            ),
          ),
        ],
      ),

      // Owner detail screens
      GoRoute(
        path: Routes.ownerOrderDetail,
        builder: (_, __) => const OrderDetailScreen(),
      ),
      GoRoute(
        path: Routes.ownerPlaceBid,
        builder: (_, __) => const PlaceBidScreen(),
      ),

      // Driver Shell
      ShellRoute(
        builder: (_, state, child) => DriverShell(child: child),
        routes: [
          GoRoute(
            path: Routes.driverHome,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: DriverHomeScreen(),
            ),
          ),
          GoRoute(
            path: Routes.driverHistory,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: DriverHistoryScreen(),
            ),
          ),
          GoRoute(
            path: Routes.driverProfile,
            pageBuilder: (_, __) => const NoTransitionPage(
              child: DriverProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});

String _homeForRole(UserRole? role) {
  return switch (role) {
    UserRole.shipper => Routes.shipperHome,
    UserRole.owner => Routes.ownerHome,
    UserRole.driver => Routes.driverHome,
    null => Routes.login,
  };
}
