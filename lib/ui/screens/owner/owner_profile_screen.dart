import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class OwnerProfileScreen extends ConsumerWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 100,
          ),
          child: Column(
            children: [
              const SizedBox(height: MtSpacing.xl),

              // Avatar
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: MtColors.surfaceElevated,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MtColors.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'AP',
                    style: MtTypography.h2.copyWith(
                      color: MtColors.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: MtSpacing.lg),

              // Name
              Text(
                user?.name ?? 'Amit Patel',
                style: MtTypography.h3,
              ),

              const SizedBox(height: MtSpacing.xs),

              // Phone
              Text(
                user?.phone ?? '+91 98765 43210',
                style: MtTypography.body.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),

              const SizedBox(height: MtSpacing.sm),

              // Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MtStarRating(rating: 4.6, size: 18),
                  const SizedBox(width: MtSpacing.sm),
                  Text(
                    '4.6',
                    style: MtTypography.label.copyWith(
                      color: MtColors.yellow,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: MtSpacing.xxl),

              // Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: MtCard(
                  variant: MtCardVariant.surface,
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatItem(
                          value: '142',
                          label: 'Total Orders',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: MtColors.border,
                      ),
                      Expanded(
                        child: _StatItem(
                          value: '3',
                          label: 'Fleet Size',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: MtColors.border,
                      ),
                      Expanded(
                        child: _StatItem(
                          value: '\u20B96.5L',
                          label: 'Total Earned',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: MtSpacing.xxl),

              // Menu sections
              _MenuSection(
                items: [
                  _MenuItem(
                    icon: Icons.local_shipping_outlined,
                    label: 'Fleet Management',
                    onTap: () => context.go(Routes.ownerFleet),
                  ),
                  _MenuItem(
                    icon: Icons.payment_outlined,
                    label: 'Payment Methods',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.account_balance_outlined,
                    label: 'Bank Details',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: MtSpacing.md),

              _MenuSection(
                items: [
                  _MenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.language_outlined,
                    label: 'Language',
                    trailing: Text(
                      'English',
                      style: MtTypography.bodySmall.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: MtSpacing.md),

              _MenuSection(
                items: [
                  _MenuItem(
                    icon: Icons.help_outline_rounded,
                    label: 'Help & Support',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.description_outlined,
                    label: 'Terms of Service',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.privacy_tip_outlined,
                    label: 'Privacy Policy',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: MtSpacing.md),

              // Logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: MtCard(
                  variant: MtCardVariant.surface,
                  padding: 0,
                  onTap: () {
                    ref.read(authProvider.notifier).logout();
                    context.go(Routes.login);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MtSpacing.lg,
                      vertical: MtSpacing.lg,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: MtColors.red,
                          size: 22,
                        ),
                        const SizedBox(width: MtSpacing.lg),
                        Text(
                          'Logout',
                          style: MtTypography.body.copyWith(
                            color: MtColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: MtSpacing.xxl),

              // Footer
              Text(
                'Member since June 2024',
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

              const SizedBox(height: MtSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: MtTypography.h4,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: MtTypography.caption.copyWith(
            color: MtColors.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _MenuSection extends StatelessWidget {
  final List<_MenuItem> items;
  const _MenuSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
      child: MtCard(
        variant: MtCardVariant.surface,
        padding: 0,
        child: Column(
          children: List.generate(items.length, (index) {
            final item = items[index];
            return Column(
              children: [
                InkWell(
                  onTap: item.onTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MtSpacing.lg,
                      vertical: MtSpacing.lg,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item.icon,
                          color: MtColors.textSecondary,
                          size: 22,
                        ),
                        const SizedBox(width: MtSpacing.lg),
                        Expanded(
                          child: Text(
                            item.label,
                            style: MtTypography.body,
                          ),
                        ),
                        if (item.trailing != null) ...[
                          item.trailing!,
                          const SizedBox(width: MtSpacing.sm),
                        ],
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: MtColors.textTertiary,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
                if (index < items.length - 1)
                  const Divider(
                    color: MtColors.border,
                    height: 1,
                    indent: MtSpacing.lg + 22 + MtSpacing.lg,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });
}
