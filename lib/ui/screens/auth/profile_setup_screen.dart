import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/user_role.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() =>
      _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _completeSetup() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    await ref.read(authProvider.notifier).completeProfile(name);
    if (!mounted) return;
    final authState = ref.read(authProvider);
    if (authState.status == AuthStatus.authenticated) {
      final role = authState.user?.role;
      context.go(switch (role) {
        UserRole.shipper => Routes.shipperHome,
        UserRole.owner => Routes.ownerHome,
        UserRole.driver => Routes.driverHome,
        null => Routes.login,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final selectedRole = authState.selectedRole;
    final nameText = _nameController.text.trim();
    final isValid = nameText.isNotEmpty;

    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: MtSpacing.xxxxl),

              // Role badge
              if (selectedRole != null)
                MtBadge(
                  label: selectedRole.label,
                  variant: MtBadgeVariant.info,
                  size: MtBadgeSize.md,
                ),
              const SizedBox(height: MtSpacing.xxl),

              // Title
              Text(
                'Set up your profile',
                style: MtTypography.h2,
              ),
              const SizedBox(height: MtSpacing.sm),

              // Subtitle
              Text(
                'Tell us about yourself',
                style: MtTypography.body.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),
              const SizedBox(height: MtSpacing.xxxxl),

              // Avatar placeholder
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: MtColors.surface,
                      child: const Icon(
                        Icons.person_rounded,
                        size: 40,
                        color: MtColors.textSecondary,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: MtColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 14,
                          color: MtColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MtSpacing.xxxxl),

              // Name input
              MtInput(
                label: 'Full Name',
                placeholder: 'Enter your full name',
                controller: _nameController,
                keyboardType: TextInputType.name,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: MtSpacing.xl),

              // Email input (optional)
              MtInput(
                label: 'Email (optional)',
                placeholder: 'Enter your email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const Spacer(),

              // Complete Setup button
              MtButton(
                title: 'Complete Setup',
                onPressed:
                    isValid && !authState.isLoading ? _completeSetup : null,
                loading: authState.isLoading,
              ),
              const SizedBox(height: MtSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
