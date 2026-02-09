import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/user_role.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the fade-in animation after a brief delay
    Future.microtask(() {
      if (mounted) {
        setState(() => _opacity = 1.0);
      }
    });

    // After 2 seconds, check auth and navigate
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      ref.read(authProvider.notifier).checkAuthStatus();
      final status = ref.read(authProvider).status;
      switch (status) {
        case AuthStatus.onboarding:
          context.go(Routes.onboarding);
        case AuthStatus.login:
          context.go(Routes.login);
        case AuthStatus.otpSent:
          context.go(Routes.verifyOtp);
        case AuthStatus.roleSelect:
          context.go(Routes.roleSelect);
        case AuthStatus.profileSetup:
          context.go(Routes.profileSetup);
        case AuthStatus.authenticated:
          final role = ref.read(authProvider).user?.role;
          context.go(switch (role) {
            UserRole.shipper => Routes.shipperHome,
            UserRole.owner => Routes.ownerHome,
            UserRole.driver => Routes.driverHome,
            null => Routes.login,
          });
        case AuthStatus.initial:
          context.go(Routes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.6, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Truck icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: MtColors.primary,
                    borderRadius: BorderRadius.circular(MtBorderRadius.xxl),
                  ),
                  child: const Icon(
                    Icons.local_shipping_rounded,
                    size: 52,
                    color: MtColors.white,
                  ),
                ),
                const SizedBox(height: MtSpacing.xxl),

                // App name
                Text(
                  'My Truck',
                  style: MtTypography.h1,
                ),
                const SizedBox(height: MtSpacing.sm),

                // Subtitle
                Text(
                  "India's Trucking Marketplace",
                  style: MtTypography.bodySmall.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
