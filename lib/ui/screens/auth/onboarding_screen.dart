import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();

  static const _pages = [
    _OnboardingPage(
      icon: Icons.local_shipping_rounded,
      title: 'Find Trucks Instantly',
      subtitle: 'Post your load, get competitive bids from verified truck owners',
    ),
    _OnboardingPage(
      icon: Icons.handshake_outlined,
      title: 'Trusted Partners',
      subtitle: 'Every truck owner and driver is verified for safe delivery',
    ),
    _OnboardingPage(
      icon: Icons.trending_up_rounded,
      title: 'Grow Your Business',
      subtitle: 'Track, manage, and scale your logistics effortlessly',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    ref.read(authProvider.notifier).skipOnboarding();
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(MtSpacing.lg),
                child: GestureDetector(
                  onTap: _onGetStarted,
                  child: Text(
                    'Skip',
                    style: MtTypography.label.copyWith(
                      color: MtColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MtSpacing.xxxl,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: MtColors.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page.icon,
                            size: 56,
                            color: MtColors.primary,
                          ),
                        ),
                        const SizedBox(height: MtSpacing.xxxxl),

                        // Title
                        Text(
                          page.title,
                          style: MtTypography.h2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: MtSpacing.md),

                        // Subtitle
                        Text(
                          page.subtitle,
                          style: MtTypography.body.copyWith(
                            color: MtColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicator
            SmoothPageIndicator(
              controller: _pageController,
              count: _pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: MtColors.primary,
                dotColor: MtColors.surfaceHighlight,
                expansionFactor: 3,
                spacing: 6,
              ),
            ),
            const SizedBox(height: MtSpacing.xxxxl),

            // Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xxl),
              child: MtButton(
                title: 'Get Started',
                onPressed: _onGetStarted,
              ),
            ),
            const SizedBox(height: MtSpacing.xxxxl),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
