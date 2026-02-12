import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class DriverProfileScreen extends ConsumerStatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  ConsumerState<DriverProfileScreen> createState() =>
      _DriverProfileScreenState();
}

class _DriverProfileScreenState extends ConsumerState<DriverProfileScreen> {
  bool _isAvailable = true;
  String _selectedLanguage = 'EN';

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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: MtSpacing.lg,
            right: MtSpacing.lg,
            top: MtSpacing.lg,
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text('Profile', style: MtTypography.h2),
              const SizedBox(height: MtSpacing.xxl),

              // Driver Info Card
              _buildDriverInfoCard(user),
              const SizedBox(height: MtSpacing.lg),

              // Availability Toggle Card
              _buildAvailabilityCard(),
              const SizedBox(height: MtSpacing.lg),

              // Stats Row Card
              _buildStatsCard(),
              const SizedBox(height: MtSpacing.xxl),

              // EARNINGS Section
              _buildSectionTitle('EARNINGS'),
              const SizedBox(height: MtSpacing.sm),
              _buildEarningsCard(),
              const SizedBox(height: MtSpacing.xxl),

              // DOCUMENTS Section
              _buildSectionTitle('DOCUMENTS'),
              const SizedBox(height: MtSpacing.sm),
              _buildDocumentsCard(),
              const SizedBox(height: MtSpacing.xxl),

              // TRUCK OWNER Section
              _buildSectionTitle('TRUCK OWNER'),
              const SizedBox(height: MtSpacing.sm),
              _buildTruckOwnerCard(),
              const SizedBox(height: MtSpacing.xxl),

              // PREFERENCES Section
              _buildSectionTitle('PREFERENCES'),
              const SizedBox(height: MtSpacing.sm),
              _buildPreferencesCard(),
              const SizedBox(height: MtSpacing.xxl),

              // SETTINGS Section
              _buildSectionTitle('SETTINGS'),
              const SizedBox(height: MtSpacing.sm),
              _buildSettingsCard(),
              const SizedBox(height: MtSpacing.xxl),

              // Log Out Button
              _buildLogOutButton(),
              const SizedBox(height: MtSpacing.xxl),

              // Footer
              _buildFooter(),
              const SizedBox(height: MtSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Driver Info Card ─────────────────────────────────────────────────
  Widget _buildDriverInfoCard(user) {
    final name = user?.name ?? 'Ramesh Yadav';
    final phone = user?.phone ?? '+91 98765 43210';
    final rating = user?.rating ?? 4.6;

    return MtCard(
      child: Row(
        children: [
          // Avatar with camera overlay
          Stack(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: MtColors.surfaceElevated,
                child: const Icon(
                  Icons.person_rounded,
                  size: 36,
                  color: MtColors.textSecondary,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _showSnack(context, 'Camera coming soon');
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: MtColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: MtColors.surface,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 12,
                      color: MtColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: MtSpacing.lg),
          // Name, Phone, Rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: MtTypography.h4),
                const SizedBox(height: 2),
                Text(
                  phone,
                  style: MtTypography.bodySmall.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
                const SizedBox(height: MtSpacing.xs),
                Row(
                  children: [
                    MtStarRating(rating: rating, size: 14),
                    const SizedBox(width: MtSpacing.xs),
                    Text(
                      rating.toString(),
                      style: MtTypography.labelSmall.copyWith(
                        color: MtColors.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Edit button
          GestureDetector(
            onTap: () {
              _showSnack(context, 'Edit Profile coming soon');
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: MtColors.surfaceElevated,
                borderRadius: BorderRadius.circular(MtBorderRadius.sm),
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: MtColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Availability Card ────────────────────────────────────────────────
  Widget _buildAvailabilityCard() {
    return MtCard(
      child: Row(
        children: [
          PulsingDot(
            size: 12,
            color: _isAvailable ? MtColors.green : MtColors.textTertiary,
          ),
          const SizedBox(width: MtSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isAvailable ? 'Available for Trips' : 'Not Available',
                  style: MtTypography.label,
                ),
                const SizedBox(height: 2),
                Text(
                  _isAvailable
                      ? 'You will receive trip assignments'
                      : 'You will not receive new trips',
                  style: MtTypography.caption.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _isAvailable,
            onChanged: (value) {
              setState(() {
                _isAvailable = value;
              });
            },
            activeThumbColor: MtColors.green,
            activeTrackColor: MtColors.green.withValues(alpha: 0.3),
            inactiveThumbColor: MtColors.textTertiary,
            inactiveTrackColor: MtColors.surfaceElevated,
          ),
        ],
      ),
    );
  }

  // ─── Stats Card ───────────────────────────────────────────────────────
  Widget _buildStatsCard() {
    return MtCard(
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Trips
            Expanded(
              child: Column(
                children: [
                  Text(
                    '142',
                    style: MtTypography.h3,
                  ),
                  const SizedBox(height: MtSpacing.xs),
                  Text(
                    'Trips',
                    style: MtTypography.caption.copyWith(
                      color: MtColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              color: MtColors.surfaceHighlight,
            ),
            // Total Earned
            Expanded(
              child: Column(
                children: [
                  Text(
                    '\u20B93,48,000',
                    style: MtTypography.h3.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: MtSpacing.xs),
                  Text(
                    'Total Earned',
                    style: MtTypography.caption.copyWith(
                      color: MtColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              color: MtColors.surfaceHighlight,
            ),
            // This Month
            Expanded(
              child: Column(
                children: [
                  Text(
                    '\u20B942,500',
                    style: MtTypography.h3.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: MtSpacing.xs),
                  Text(
                    'This Month',
                    style: MtTypography.caption.copyWith(
                      color: MtColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Earnings Card ────────────────────────────────────────────────────
  Widget _buildEarningsCard() {
    return MtCard(
      child: Column(
        children: [
          // This month row
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: MtColors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(MtBorderRadius.sm),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  size: 20,
                  color: MtColors.green,
                ),
              ),
              const SizedBox(width: MtSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This Month',
                      style: MtTypography.bodySmall.copyWith(
                        color: MtColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\u20B942,500',
                      style: MtTypography.h4.copyWith(
                        color: MtColors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: MtSpacing.lg),
          Divider(
            color: MtColors.surfaceHighlight,
            height: 1,
          ),
          const SizedBox(height: MtSpacing.lg),
          // All time row
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: MtColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(MtBorderRadius.sm),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 20,
                  color: MtColors.primary,
                ),
              ),
              const SizedBox(width: MtSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Time',
                      style: MtTypography.bodySmall.copyWith(
                        color: MtColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\u20B93,48,000',
                      style: MtTypography.h4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Documents Card ───────────────────────────────────────────────────
  Widget _buildDocumentsCard() {
    return MtCard(
      child: Column(
        children: [
          _buildDocumentRow(
            icon: Icons.badge_outlined,
            title: 'Driving License',
            subtitle: 'Expires: Mar 2028',
            statusLabel: 'Verified',
            statusVariant: MtBadgeVariant.success,
          ),
          const SizedBox(height: MtSpacing.md),
          Divider(color: MtColors.surfaceHighlight, height: 1),
          const SizedBox(height: MtSpacing.md),
          _buildDocumentRow(
            icon: Icons.credit_card_outlined,
            title: 'Aadhaar Card',
            subtitle: '****-****-4521',
            statusLabel: 'Verified',
            statusVariant: MtBadgeVariant.success,
          ),
          const SizedBox(height: MtSpacing.md),
          Divider(color: MtColors.surfaceHighlight, height: 1),
          const SizedBox(height: MtSpacing.md),
          _buildDocumentRow(
            icon: Icons.description_outlined,
            title: 'PAN Card',
            subtitle: '',
            statusLabel: 'Pending',
            statusVariant: MtBadgeVariant.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String statusLabel,
    required MtBadgeVariant statusVariant,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: MtColors.surfaceElevated,
            borderRadius: BorderRadius.circular(MtBorderRadius.sm),
          ),
          child: Icon(icon, size: 20, color: MtColors.textSecondary),
        ),
        const SizedBox(width: MtSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: MtTypography.label),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: MtTypography.caption.copyWith(
                    color: MtColors.textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ),
        MtBadge(
          label: statusLabel,
          variant: statusVariant,
        ),
      ],
    );
  }

  // ─── Truck Owner Card ─────────────────────────────────────────────────
  Widget _buildTruckOwnerCard() {
    return MtCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: MtColors.surfaceElevated,
              borderRadius: BorderRadius.circular(MtBorderRadius.md),
            ),
            child: const Icon(
              Icons.business_rounded,
              size: 24,
              color: MtColors.primary,
            ),
          ),
          const SizedBox(width: MtSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sharma Transport Co.',
                  style: MtTypography.label,
                ),
                const SizedBox(height: 2),
                Text(
                  '+91 98765 12345',
                  style: MtTypography.bodySmall.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Call button
          GestureDetector(
            onTap: () {
              _showSnack(context, 'Calling Sharma Transport Co...');
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: MtColors.green.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_outlined,
                size: 20,
                color: MtColors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Preferences Card ─────────────────────────────────────────────────
  Widget _buildPreferencesCard() {
    return MtCard(
      child: Row(
        children: [
          const Icon(
            Icons.language_rounded,
            size: 20,
            color: MtColors.textSecondary,
          ),
          const SizedBox(width: MtSpacing.md),
          Text(
            'Language',
            style: MtTypography.label,
          ),
          const Spacer(),
          // Pill-style selector
          Container(
            decoration: BoxDecoration(
              color: MtColors.surfaceElevated,
              borderRadius: BorderRadius.circular(MtBorderRadius.full),
            ),
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLanguagePill('EN'),
                const SizedBox(width: 2),
                _buildLanguagePill('HI'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagePill(String lang) {
    final isSelected = _selectedLanguage == lang;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = lang;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: MtSpacing.lg,
          vertical: MtSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? MtColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(MtBorderRadius.full),
        ),
        child: Text(
          lang,
          style: MtTypography.labelSmall.copyWith(
            color: isSelected ? MtColors.white : MtColors.textTertiary,
          ),
        ),
      ),
    );
  }

  // ─── Settings Card ────────────────────────────────────────────────────
  Widget _buildSettingsCard() {
    return MtCard(
      child: Column(
        children: [
          _buildSettingsRow(
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            onTap: () {
              _showSnack(context, 'Notification Settings coming soon');
            },
          ),
          _buildSettingsDivider(),
          _buildSettingsRow(
            icon: Icons.help_outline_rounded,
            label: 'Help & Support',
            onTap: () {
              _showSnack(context, 'Help & Support coming soon');
            },
          ),
          _buildSettingsDivider(),
          _buildSettingsRow(
            icon: Icons.description_outlined,
            label: 'Terms of Service',
            onTap: () {
              _showSnack(context, 'Terms of Service coming soon');
            },
          ),
          _buildSettingsDivider(),
          _buildSettingsRow(
            icon: Icons.shield_outlined,
            label: 'Privacy Policy',
            onTap: () {
              _showSnack(context, 'Privacy Policy coming soon');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MtSpacing.md),
        child: Row(
          children: [
            Icon(icon, size: 20, color: MtColors.textSecondary),
            const SizedBox(width: MtSpacing.md),
            Expanded(
              child: Text(label, style: MtTypography.body),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: MtColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsDivider() {
    return Divider(
      color: MtColors.surfaceHighlight,
      height: 1,
    );
  }

  // ─── Log Out Button ───────────────────────────────────────────────────
  Widget _buildLogOutButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          ref.read(authProvider.notifier).logout();
          context.go(Routes.login);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MtSpacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.logout_rounded,
                size: 20,
                color: MtColors.red,
              ),
              const SizedBox(width: MtSpacing.sm),
              Text(
                'Log Out',
                style: MtTypography.label.copyWith(
                  color: MtColors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Footer ───────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Center(
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
    );
  }

  // ─── Section Title ────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: MtTypography.labelTiny.copyWith(
        color: MtColors.textTertiary,
        letterSpacing: 1.2,
      ),
    );
  }
}
