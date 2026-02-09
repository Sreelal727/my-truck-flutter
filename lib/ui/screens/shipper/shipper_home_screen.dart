import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class ShipperHomeScreen extends ConsumerWidget {
  const ShipperHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userName = authState.user?.name.split(' ').first ?? 'Rajesh';

    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MtSpacing.xl, MtSpacing.xl, MtSpacing.xl, MtSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, $userName',
                          style: MtTypography.h2,
                        ),
                        const SizedBox(height: MtSpacing.xs),
                        Text(
                          'Where are you shipping?',
                          style: MtTypography.body.copyWith(
                            color: MtColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => context.go(Routes.shipperNotifications),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: MtColors.surface,
                          borderRadius: BorderRadius.circular(MtBorderRadius.md),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: MtColors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0),

              // Post a New Load button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MtSpacing.xl,
                  vertical: MtSpacing.lg,
                ),
                child: MtButton(
                  title: 'Post a New Load',
                  icon: const Icon(Icons.add_rounded, color: MtColors.black, size: 20),
                  onPressed: () => context.push(Routes.shipperCreateOrder),
                ),
              ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              // Active Orders section
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MtSpacing.xl, MtSpacing.lg, MtSpacing.xl, MtSpacing.md,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Active Orders', style: MtTypography.h4),
                    GestureDetector(
                      onTap: () => context.go(Routes.shipperOrders),
                      child: Text(
                        'See All',
                        style: MtTypography.labelSmall.copyWith(
                          color: MtColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              // Order Card 1 - Mumbai -> Pune, Bidding
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MtSpacing.xl,
                  vertical: MtSpacing.sm,
                ),
                child: MtCard(
                  onTap: () => context.push(Routes.shipperBidding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ORD-1001',
                            style: MtTypography.labelSmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          const MtBadge(
                            label: 'Bidding',
                            variant: MtBadgeVariant.warning,
                          ),
                        ],
                      ),
                      const SizedBox(height: MtSpacing.md),
                      _buildRouteInfo(
                        'Andheri East, Mumbai',
                        'Hinjewadi, Pune',
                      ),
                      const SizedBox(height: MtSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\u20B918,500',
                            style: MtTypography.h4.copyWith(
                              color: MtColors.green,
                            ),
                          ),
                          Text(
                            '3 bids \u2022 45 min left',
                            style: MtTypography.caption.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              // Order Card 2 - Delhi -> Jaipur, In Transit
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MtSpacing.xl,
                  vertical: MtSpacing.sm,
                ),
                child: MtCard(
                  onTap: () => context.push(Routes.shipperTracking),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ORD-1002',
                            style: MtTypography.labelSmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          const MtBadge(
                            label: 'In Transit',
                            variant: MtBadgeVariant.info,
                          ),
                        ],
                      ),
                      const SizedBox(height: MtSpacing.md),
                      _buildRouteInfo(
                        'Naraina, New Delhi',
                        'Mansarovar, Jaipur',
                      ),
                      const SizedBox(height: MtSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\u20B932,000',
                            style: MtTypography.h4.copyWith(
                              color: MtColors.green,
                            ),
                          ),
                          Text(
                            'ETA: 4 hrs',
                            style: MtTypography.caption.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              // Recent Activity section
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MtSpacing.xl, MtSpacing.xxl, MtSpacing.xl, MtSpacing.md,
                ),
                child: Text('Recent Activity', style: MtTypography.h4),
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

              _buildActivityItem(
                icon: Icons.check_circle_rounded,
                iconColor: MtColors.green,
                title: 'Order ORD-998 delivered successfully',
                time: '2 hours ago',
              ).animate().fadeIn(delay: 550.ms, duration: 400.ms).slideX(begin: 0.05, end: 0),

              _buildActivityItem(
                icon: Icons.local_offer_rounded,
                iconColor: MtColors.orange,
                title: 'New bid received on ORD-1001',
                time: '5 hours ago',
              ).animate().fadeIn(delay: 600.ms, duration: 400.ms).slideX(begin: 0.05, end: 0),

              _buildActivityItem(
                icon: Icons.payment_rounded,
                iconColor: MtColors.primary,
                title: 'Payment of \u20B925,000 processed',
                time: 'Yesterday',
              ).animate().fadeIn(delay: 650.ms, duration: 400.ms).slideX(begin: 0.05, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteInfo(String pickup, String drop) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: MtColors.green,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 24,
              color: MtColors.surfaceHighlight,
            ),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: MtColors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(width: MtSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pickup,
                style: MtTypography.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: MtSpacing.lg),
              Text(
                drop,
                style: MtTypography.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MtSpacing.xl,
        vertical: MtSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(MtBorderRadius.md),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: MtSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MtTypography.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: MtTypography.caption.copyWith(
                    color: MtColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
