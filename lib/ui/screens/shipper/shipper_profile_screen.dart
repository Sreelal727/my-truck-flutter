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

class ShipperProfileScreen extends ConsumerWidget {
  const ShipperProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MtSpacing.xl, MtSpacing.xl, MtSpacing.xl, MtSpacing.lg,
                ),
                child: Text('Profile', style: MtTypography.h2),
              ),

              // User info card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: MtCard(
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: MtColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(
                            MtBorderRadius.full,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: MtColors.textSecondary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: MtSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'Rajesh Kumar',
                              style: MtTypography.h4,
                            ),
                            const SizedBox(height: MtSpacing.xs),
                            Text(
                              user?.phone ?? '+91 98765 43210',
                              style: MtTypography.bodySmall.copyWith(
                                color: MtColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: MtSpacing.xs),
                            Row(
                              children: [
                                MtStarRating(
                                  rating: user?.rating ?? 4.5,
                                  size: 14,
                                ),
                                const SizedBox(width: MtSpacing.xs),
                                Text(
                                  (user?.rating ?? 4.5).toString(),
                                  style: MtTypography.caption.copyWith(
                                    color: MtColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showSnack(context, 'Edit Profile coming soon'),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: MtColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(
                              MtBorderRadius.md,
                            ),
                          ),
                          child: const Icon(
                            Icons.edit_rounded,
                            color: MtColors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 300.ms),

              const SizedBox(height: MtSpacing.xxl),

              // Stats row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: Row(
                  children: [
                    _buildStatCard(
                      'Total Orders',
                      32,
                      null,
                    ),
                    const SizedBox(width: MtSpacing.md),
                    _buildStatCard(
                      'Active',
                      3,
                      null,
                    ),
                    const SizedBox(width: MtSpacing.md),
                    _buildStatCard(
                      'Spent',
                      185,
                      '\u20B9',
                      suffix: 'K',
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

              const SizedBox(height: MtSpacing.xxl),

              // Menu items
              _buildMenuItem(
                context,
                icon: Icons.payment_rounded,
                iconBgColor: MtColors.primary,
                label: 'Payment Methods',
                onTap: () => _showSnack(context, 'Payment Methods coming soon'),
              ).animate().fadeIn(delay: 150.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              _buildMenuItem(
                context,
                icon: Icons.location_on_rounded,
                iconBgColor: MtColors.green,
                label: 'Address Book',
                onTap: () => _showSnack(context, 'Address Book coming soon'),
              ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              _buildMenuItem(
                context,
                icon: Icons.notifications_rounded,
                iconBgColor: MtColors.orange,
                label: 'Notifications',
                onTap: () => _showSnack(context, 'Notification Settings coming soon'),
              ).animate().fadeIn(delay: 250.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              _buildMenuItem(
                context,
                icon: Icons.language_rounded,
                iconBgColor: MtColors.yellow,
                label: 'Language',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MtSpacing.md,
                    vertical: MtSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: MtColors.surface,
                    borderRadius: BorderRadius.circular(MtBorderRadius.full),
                  ),
                  child: Text(
                    'EN',
                    style: MtTypography.labelSmall.copyWith(
                      color: MtColors.textSecondary,
                    ),
                  ),
                ),
                onTap: () => _showSnack(context, 'Language Settings coming soon'),
              ).animate().fadeIn(delay: 300.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              _buildMenuItem(
                context,
                icon: Icons.help_outline_rounded,
                iconBgColor: MtColors.primaryLight,
                label: 'Help & Support',
                onTap: () => _showSnack(context, 'Help & Support coming soon'),
              ).animate().fadeIn(delay: 350.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              _buildMenuItem(
                context,
                icon: Icons.description_outlined,
                iconBgColor: MtColors.textSecondary,
                label: 'Terms & Conditions',
                onTap: () => _showSnack(context, 'Terms & Conditions coming soon'),
              ).animate().fadeIn(delay: 400.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              _buildMenuItem(
                context,
                icon: Icons.shield_outlined,
                iconBgColor: MtColors.textSecondary,
                label: 'Privacy Policy',
                onTap: () => _showSnack(context, 'Privacy Policy coming soon'),
              ).animate().fadeIn(delay: 450.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              _buildMenuItem(
                context,
                icon: Icons.logout_rounded,
                iconBgColor: MtColors.red,
                label: 'Logout',
                labelColor: MtColors.red,
                showChevron: false,
                onTap: () {
                  ref.read(authProvider.notifier).logout();
                  context.go(Routes.login);
                },
              ).animate().fadeIn(delay: 500.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),

              const SizedBox(height: MtSpacing.xxxl),

              // Footer
              Center(
                child: Column(
                  children: [
                    Text(
                      'Member since August 2024',
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: MtSpacing.xs),
                    Text(
                      'My Truck v1.0.0',
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 550.ms, duration: 300.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    int value,
    String? prefix, {
    String? suffix,
  }) {
    return Expanded(
      child: MtCard(
        child: Column(
          children: [
            AnimatedCounter(
              value: value,
              prefix: prefix,
              suffix: suffix,
              style: MtTypography.h3,
            ),
            const SizedBox(height: MtSpacing.xs),
            Text(
              label,
              style: MtTypography.caption.copyWith(
                color: MtColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required String label,
    Color? labelColor,
    Widget? trailing,
    bool showChevron = true,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MtSpacing.xl,
          vertical: MtSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(MtBorderRadius.sm),
              ),
              child: Icon(icon, color: iconBgColor, size: 20),
            ),
            const SizedBox(width: MtSpacing.lg),
            Expanded(
              child: Text(
                label,
                style: MtTypography.body.copyWith(
                  color: labelColor ?? MtColors.white,
                ),
              ),
            ),
            ?trailing,
            if (showChevron)
              const Icon(
                Icons.chevron_right_rounded,
                color: MtColors.textTertiary,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}

void _showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: MtColors.surfaceElevated,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 2),
    ),
  );
}
